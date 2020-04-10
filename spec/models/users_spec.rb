require 'rails_helper'

RSpec.describe "Users", type: :models do 
  describe "validations" do 
    context "with wrong format" do 
      it "validate email" do
        user = build(:user, email: Faker::Lorem.word)
        expect(user).not_to be_valid
      end
    end

    context "with right format" do 
      it "validate email" do 
        user = build(:user)
        expect(user).to be_valid
      end
    end

    context "with wrong length" do 
      it "username with length under limit" do
        user = build(:user, username: Faker::Lorem.characters(number: 4))
        expect(user).not_to be_valid
      end

      it "username with lenght over limit" do 
        user = build(:user, username: Faker::Lorem.characters(number: 21))
        expect(user).not_to be_valid
      end

      it "password with length under limit" do 
        user = build(:user, password: Faker::Lorem.characters(number:4))
        expect(user).not_to be_valid
      end

      it "password with length over limit" do 
        user = build(:user, password: Faker::Lorem.characters(number: 16))
        expect(user).not_to be_valid
      end
    end

    context "with right length" do 
      it "validate username" do
        user = build(:user, username: Faker::Lorem.characters(number: 10))
        expect(user).to be_valid
      end

      it "validate password" do 
        user = build(:user, username: Faker::Lorem.characters(number: 10))
        expect(user).to be_valid
      end
    end

    context "without presence" do 
      it "validate email" do 
        user = build(:user, email: nil)
        expect(user).not_to be_valid
      end

      it "validate username" do 
        user = build(:user, username: nil)
        expect(user).not_to be_valid
      end

      it "valdiate password" do 
        user = build(:user, password: nil)
        expect(user).not_to be_valid
      end

      context "with presence" do 
        it "validate email" do 
          user = build(:user, email: Faker::Internet.email)
          expect(user).to be_valid
        end

        it "validate username" do 
          user = build(:user, username: Faker::Lorem.characters(number: 10))
          expect(user).to be_valid
        end

        it "validate password" do 
          user = build(:user, password: Faker::Lorem.characters(number: 10))
          expect(user).to be_valid
        end 
      end
    end


    context "with duplicated values" do 
      it "verify email" do 
        user = create(:user)
        user2 = build(:user, email: user.email)
        expect(user2).not_to be_valid
      end

      it "verify username" do 
        user = create(:user)
        user2 = build(:user, username: user.username)
        expect(user2).not_to be_valid
      end
    end 

    context "with right values" do 
      it "create user" do
        user = build(:user)
        expect(user).to be_valid
      end
    end
  end
end
