require 'spec_helper'

module Refinery
  module Redirections
    describe Redirection do
      describe "validations", type: :model do
        before do
          Refinery::Redirections::Redirection.delete_all
        end

        subject do
          FactoryBot.create(:redirection, from_url: "Refinery CMS")
        end

        it 'is valid' do
          expect(subject).to be_valid
        end

        it 'has no errors' do
          expect(subject.errors).to be_blank
        end

        describe '#sanitize paths' do
          [
            [
              "/path-with-undesired-params?page=2&a=1",
              ["a"], "/path-with-undesired-params?page=2"
            ],
            [
              "/path-with-unsorted-params?b=0&a=1",
              [], "/path-with-unsorted-params?a=1&b=0"
            ]
          ].each do |original_path, undesired_params, sanitized_path|

            context "when creating redirection to #{original_path}" do
              let(:redirection) { create :redirection, from_url: original_path }

              before do
                Refinery::Redirections.ignored_path_params = undesired_params
                redirection
              end

              it "sanitizes it into #{sanitized_path}" do
                expect(
                  Refinery::Redirections::Redirection.sanitize_path(original_path)
                ).to eq sanitized_path
              end

              it "saves it sanitized" do
                expect(redirection.from_url).to eq sanitized_path
              end

              it "is found by the non sanitized path" do
                expect(
                  Refinery::Redirections::Redirection.from_url(sanitized_path)
                ).to match_array [redirection]
              end

              it "is found by the sanitized path" do
                expect(
                  Refinery::Redirections::Redirection.from_url(sanitized_path)
                ).to match_array [redirection]
              end

              it "cannot be found by any other random path" do
                expect(
                  Refinery::Redirections::Redirection.from_url(
                    'yeah-it-should-be-funny-huh?'
                  )
                ).to be_blank
              end
            end
          end
        end
      end
    end
  end
end
