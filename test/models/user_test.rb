# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'input user' do
    user = User.new(email: 'a', password: 'a')
    assert user.valid?
  end
end
