# frozen_string_literal: true

class ActiveSupport::TestCase
  def sign_in(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      :github,
      {
        uid: Faker::Internet.uuid,
        info: { email: user[:email] }
      }
    )

    get callback_auth_path(:github)
    user
  end

  def sign_out(user)
    delete session_path(session.id)
  end
end