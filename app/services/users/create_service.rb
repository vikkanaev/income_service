module Users
  class CreateService
    prepend BasicService

    param :email
    param :password

    attr_reader :user

    def call
      @user = User.new(
        email: @email,
        password: @password
      )

      fail!(@user.errors) unless @user.save
    end
  end
end
