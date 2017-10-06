class Refinery::Redirections::Redirection < ActiveRecord::Base
  extend Enumerize

  enumerize :status_code, in: %w[301 302 303 307]

  validates :from_url, :status_code, :to_url, presence: true

  before_save :sanitize_path

  def sanitize_path
    self.from_url = self.class.sanitize_path from_url
  end

  scope :from_url, ->(path) { where from_url: sanitize_path(path) }

  # This method gets a path and 'sanitizes it'. This means that all the params
  # that we don't want (Google Analytics params, testing params...) are
  # stripped out and params are sorted so '/en?a=1&b=1' and '/en?b=1&a=1'
  # are the same
  def self.sanitize_path(
    path, ignored_path_params = Refinery::Redirections.ignored_path_params
  )
    path, params = path.split('?')
    if params.blank?
      path
    else
      # We split the params
      params = params.split('&')
      # And then get those ignored and remove them
      not_ignored_params = params.reject do |p|
        ignored_path_params.detect do |ignored|
          p.start_with?("#{ignored}=") || (p == ignored)
        end
      end

      if not_ignored_params.blank?
        path
      else
        "#{path}?#{not_ignored_params.sort.join('&')}"
      end
    end
  end

  def title
    "#{from_url} -> #{to_url} (#{status_code})"
  end
end
