require 'spec_helper'

module Refinery
  module Redirections
    describe Redirection do
      describe "validations", type: :model do
        subject do
          FactoryBot.create(:redirection, from_url: "Refinery CMS")
        end

        it 'is valid' do
          expect(subject).to be_valid
        end

        it 'has no errors' do
          expect(subject.errors).to be_blank
        end
      end
    end
  end
end
