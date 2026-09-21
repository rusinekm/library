require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'validations' do
    let(:build_author) { build(:author) }
    let(:build_author_without_full_name) { build(:author, full_name: nil) }
    it 'is valid with a full_name' do
      expect(build_author).to be_valid
    end

    it 'is invalid without a full_name' do
      expect(build_author_without_full_name).not_to be_valid
    end
  end
end
