require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    
    # Criar um post válido com ActionText::RichText
    @post = Post.new(
      title: "Post de Teste para System Test",
      user: @user
    )
    
    # Configurando o rich_text content corretamente
    @post.content = ActionText::Content.new("Este é o conteúdo de teste para o system test, precisa ter mais de 10 caracteres")
    @post.save!
    
    # Fazer login como usuário
    system_login_as(@user)
  end

  test "visiting the index" do
    visit posts_url
    # search for class .post
    assert_selector ".post"
  end

  test "should create post" do
    visit posts_url
    find("#admin-btn").click
    click_on "Novo Post"

    fill_in "Titulo", with: "Novo Post via System Test"
    
    # Interagir com o editor Trix
    find("trix-editor").click
    find("trix-editor").set("Este é o conteúdo do novo post via system test")
    
    click_on "Create Post"

    assert_text "Post was successfully created"
  end

  test "should update Post" do
    visit post_url(@post)
    click_on "Editar", match: :first

    fill_in "Titulo", with: "Post Atualizado via System Test"
    
    # Interagir com o editor Trix
    find("trix-editor").click
    find("trix-editor").set("Este é o conteúdo atualizado via system test")
    
    click_on "Update Post"

    assert_text "Post was successfully updated"
  end

  test "should destroy Post" do
    visit post_url(@post)
    click_on "Apagar", match: :first

    assert_text "Post was successfully destroyed"
  end
end