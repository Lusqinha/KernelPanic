require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    @post.user = @user
    @post.content = ActionText::Content.new("Este é o conteúdo de teste com mais de 10 caracteres")
    @post.save!
    login_as(@user)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: {
        post: {
          title: "Novo Post de Teste",
          content: "Este é o conteúdo do novo post para teste que precisa ter pelo menos 10 caracteres."
        }
       }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should show post if not drafted" do
    get post_url(@post)
    assert_response :success
  end

  test "should not show post if drafted" do
    @post.draft = true
    @post.save!
    get post_url(@post)
    assert_redirected_to posts_url
    assert_equal "Post not found", flash[:alert]
  end

  test "should not show post if drafted and user is not the owner" do
    @post.draft = true
    @post.user = users(:two)
    @post.save!
    get post_url(@post)
    assert_redirected_to posts_url
    assert_equal "Post not found", flash[:alert]
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: {
        post: {
          title: "Novo Post de Teste",
          content: "Este é o conteúdo do novo post para teste que precisa ter pelo menos 10 caracteres."
        }
     }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
