FactoryBot.define do
  factory :redirection, class: Refinery::Redirections::Redirection do
    from_url { "/#{FFaker::Lorem.words(3).map(&:downcase).join('/')}" }
    to_url { "/#{FFaker::Lorem.words(3).map(&:downcase).join('/')}" }
    status_code do
      Refinery::Redirections::Redirection.status_code.values.sample
    end
  end
end
