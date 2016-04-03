class Stylesheet < ApplicationRecord
  VERSIONS = {
    bootstrap: %w(4-alpha)
  }

  belongs_to :account, inverse_of: :stylesheets
  has_many :variables, inverse_of: :stylesheet

  validates :framework, :name, :version, presence: true

  def self.framework_select_options
    VERSIONS.keys.map do |framework|
      [framework.capitalize, framework]
    end
  end
end
