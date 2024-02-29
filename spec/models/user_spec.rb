require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should be valid with valid attributes' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )
      expect(user).to be_valid
    end

    it 'should require password and password_confirmation fields' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe'
      )
      user.save
      expect(user.errors.full_messages).to include("Password can't be blank", "Password confirmation can't be blank")
    end

    it 'should expect password and password_confirmation fields to be similar' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'different_password',
        first_name: 'John',
        last_name: 'Doe'
      )
      user.save
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should validate uniqueness of email (case-insensitive)' do
      User.create!(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )
      user = User.new(
        email: 'TEST@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Jane',
        last_name: 'Doe'
      )
      user.save
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'should require email, first name, and last name' do
      user = User.new(
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank", "First name can't be blank", "Last name can't be blank")
    end

    it 'should have a minimum length for the password' do
      user = User.new(
        email: 'test@example.com',
        password: 'short',
        password_confirmation: 'short',
        first_name: 'John',
        last_name: 'Doe'
      )
      user.save
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

    it 'should allow passwords with the minimum required length' do
      user = User.new(
        email: 'test@example.com',
        password: 'long_enough_password',
        password_confirmation: 'long_enough_password',
        first_name: 'John',
        last_name: 'Doe'
      )
      user.save
      expect(user).to be_valid
    end
  end


   describe '.authenticate_with_credentials' do


    it 'returns the user instance if successfully authenticated' do
   
      user = User.find_by_email ('test@example.com')

      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'returns nil if email is invalid' do
      authenticated_user = User.authenticate_with_credentials('invalid@example.com', 'password')
      expect(authenticated_user).to be_nil
    end

    it 'returns nil if password is invalid' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'invalid_password')
      expect(authenticated_user).to be_nil
    end

    it 'ignores leading and trailing whitespaces in email' do
       user = User.find_by_email ('test@example.com')

      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'ignores case sensitivity in email' do
       user = User.find_by_email ('test@example.com')

      authenticated_user = User.authenticate_with_credentials('TEST@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end
  end

end
