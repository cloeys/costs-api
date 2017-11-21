require 'rails_helper'

RSpec.describe Cost, type: :model do
  it { should belong_to(:user) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount) }
end
