require "net/http"
require "json"
require "open-uri"

class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  before_save :attach_avatar_from_github

  def attach_avatar_from_github
    return unless github_username.present?

    url = "https://api.github.com/users/#{github_username}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    user_data = JSON.parse(response)

    if user_data["avatar_url"]
      self.avatar.attach(io: URI.open(user_data["avatar_url"]), filename: "#{github_username}_avatar.jpg")
    end
  rescue StandardError => e
    Rails.logger.error("Erro ao buscar avatar do GitHub: #{e.message}")
  end
end
