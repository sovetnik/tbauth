# frozen_string_literal: true
require 'rails_helper'

describe User, type: :model do

  let(:user) { create :user }

  describe '#set_token!' do
    it 'set a new SecureRandom string as token' do
      hex = SecureRandom.hex
      allow(SecureRandom).to receive(:hex).and_return(hex)
      user.set_token!
      expect(user.token).to eq hex
    end
  end

  describe '#forget_token!' do
    it 'set nil to token' do
      user.set_token!
      user.forget_token!
      expect(user.token).to eq nil
    end
  end

  describe 'get_token' do
    let(:subject) { user.get_token }

    context 'if token set' do
      before { user.set_token! }
      it 'returnes a same token string for each call' do
        expect(subject).to_not eq nil
        expect(subject).to eq subject
      end
    end

    context 'if token not set' do
      before { user.forget_token! }
      it 'returnes a same token string for each call' do
        expect(subject).to_not eq nil
        expect(subject).to eq subject
      end
    end
  end
end
