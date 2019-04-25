require "spec_helper"

describe Refinery do
  describe "Redirections" do
    describe "Admin" do
      describe "redirections", type: :feature do
        refinery_login

        before do
          Refinery::Redirections::Redirection.delete_all
        end

        describe "redirections list" do
          before do
            FactoryBot.create(:redirection, from_url: "UniqueTitleOne")
            FactoryBot.create(:redirection, from_url: "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.redirections_admin_redirections_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.redirections_admin_redirections_path

            click_link "Add New Redirection"
          end

          context "valid data" do
            it "succeeds" do
              fill_in(
                "From Url", with: "This is a test of the first string field"
              )
              fill_in(
                "To Url", with: "This is a test of the second string field"
              )
              select 'Permanent Redirect (301)'

              expect { click_button "Save" }.to change(
                Refinery::Redirections::Redirection, :count
              ).from(0).to(1)
              
              visit refinery.redirections_admin_redirections_path

              expect(page).to have_content(
                "'This is a test of the first string field' was " \
                "successfully added."
              )
            end
          end

          context "invalid data" do
            it "fails" do
              expect { click_button "Save" }.not_to change(
                Refinery::Redirections::Redirection, :count
              )

              expect(page).to have_content("From Url can't be blank")
            end
          end

          context "duplicate" do
            before do
              FactoryBot.create(:redirection, from_url: "UniqueTitle")
            end

            it "fails" do
              visit refinery.redirections_admin_redirections_path

              click_link "Add New Redirection"

              fill_in "From Url", with: "UniqueTitle"
              expect { click_button "Save" }.not_to change(
                Refinery::Redirections::Redirection, :count
              )

              expect(page).to have_content("There were problems")
            end
          end
        end

        describe "edit" do
          before { FactoryBot.create(:redirection, from_url: "A from_url") }

          it "succeeds" do
            visit refinery.redirections_admin_redirections_path

            within ".actions" do
              click_link "Edit this redirection"
            end

            fill_in "From Url", with: "A different from_url"
            click_button "Save"

            expect(page).to have_content(
              "'A different from_url' was successfully updated."
            )
            expect(page).not_to have_content("A from_url")
          end
        end

        describe "destroy" do
          before { FactoryBot.create(:redirection, from_url: "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.redirections_admin_redirections_path

            click_link "Remove this redirection forever"

            expect(page).to have_content(
              "'UniqueTitleOne' was successfully removed."
            )
            expect(Refinery::Redirections::Redirection.count).to eq(0)
          end
        end
      end
    end
  end
end
