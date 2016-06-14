class Stylesheet < ApplicationRecord
  VERSIONS = {
    bootstrap: %w(3.3 4-alpha-2)
  }

  belongs_to :account, inverse_of: :stylesheets
  has_many :variables, inverse_of: :stylesheet

  validates :framework, :name, :version, presence: true

  accepts_nested_attributes_for :variables

  def self.framework_select_options
    VERSIONS.keys.map do |framework|
      [framework.capitalize, framework]
    end
  end
end
