# frozen_string_literal: true

require './test/test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  test 'unauthorized user will be redirected to email page' do
    get lr8_logic_input_url
    assert_redirected_to controller: :session, action: :login
  end

  test 'user with incorrect credentials will be redirected to email page' do
    post session_create_url, params: { email: Faker::Lorem.word, password: Faker::Lorem.word }
    assert_redirected_to controller: :session, action: :login
  end

  test 'user with correct credentials will see the root' do
    password = Faker::Lorem.word

    user = User.create(email: Faker::Lorem.word, password: password, password_confirmation: password)

    post session_create_url, params: { email: user.email, password: password }

    assert_redirected_to controller: :lr8_logic, action: :input
  end

  test 'user will see the root after signing up' do
    email = Faker::Lorem.word
    password = Faker::Lorem.word

    post users_url, params: { user: { email: email, password: password, password_confirmation: password } }

    assert_redirected_to user_url(User.last)
  end

  test 'user can logout' do
    password = Faker::Lorem.word

    user = User.create(email: Faker::Lorem.word, password: password, password_confirmation: password)

    post session_create_url, params: { email: user.email, password: password }

    get session_logout_url

    assert_redirected_to controller: :session, action: :login
  end
end
