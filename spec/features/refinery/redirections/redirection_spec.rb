require 'spec_helper'
require_relative '../../../support/helpers/visit_without_redirects_helper'

module Refinery
  module Redirections
    describe 'Redirections', type: :feature do
      include VisitWithoutRedirectsHelper

      before do
        Refinery::Redirections::Redirection.delete_all
        allow_any_instance_of(::ApplicationController)
          .to receive(:refinery_user_required?).and_return(false)
      end

      let(:redirection) { create :redirection }

      context 'when redirection exists' do
        before do
          visit_without_redirects redirection.from_url
        end

        it 'redirects' do
          expect(page.status_code).to eq redirection.status_code
          expect(redirected_url).to eq(
            "http://www.example.com#{redirection.to_url}"
          )
        end
      end

      context 'when redirection does not exist' do
        before do
          visit_without_redirects '/'
        end

        it 'redirects' do
          expect(page.status_code).to eq 404
        end
      end
    end
  end
end
