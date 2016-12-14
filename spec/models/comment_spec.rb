require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#less_than_three_levels_deep?' do
    let(:user)    { FactoryGirl.create(:user) }
    let(:stylist) { FactoryGirl.create(:stylist, user: user) }
    let(:work)    { FactoryGirl.create(:work, stylist: stylist) }

    context '1 level deep' do
      it 'returns true' do
        comment = work.comments.create(body: 'foo', user: user)
        expect(comment.less_than_three_levels_deep?).to eq(true)
      end
    end

    context '3 levels deep' do
      let!(:first_level_comment)  { work.comments.create(body: 'first_level', user: user) }
      let!(:second_level_comment) { first_level_comment.comments.create(body: 'second_level', user: user) }

      it 'returns true' do
        third_level_comment = second_level_comment.comments.create(body: 'third_level', user: user)
        expect(third_level_comment.less_than_three_levels_deep?).to eq(true)
      end
    end

    context '4 levels deep' do
      let!(:first_level_comment)  { work.comments.create(body: 'first_level', user: user) }
      let!(:second_level_comment) { first_level_comment.comments.create(body: 'second_level', user: user) }
      let!(:third_level_comment)  { second_level_comment.comments.create(body: 'third_level', user: user) }

      it 'returns false' do
        fourth_level_comment = third_level_comment.comments.create(body: 'fourth_level', user: user)
        expect(fourth_level_comment.less_than_three_levels_deep?).to eq(false)
      end
    end
  end
end
