RSpec.describe 'GoogleAds::CostBenefit' do

  context 'List' do
    it 'cost_benefit_per_video' do
      groups = GoogleAds::CostBenefit.new.per_video
      result = [
          { id_video_principal: 'v1', cost_benefit: 7.35 },#((712 + (46.43 * 2) + (30.92 * 4) + (25.17 * 5) + (17.97 * 3))/15)/ 10.05).floor(2)
          { id_video_principal: 'v10', cost_benefit: 7.56 },#(((595 + (29.519 * 2) + (17.27 * 4) + (10.07 * 5) + (5.5 * 3))/15)/ 6.96).floor(2)
      ]
      expect(true).to be groups.include? result[0]
      expect(true).to be groups.include? result[1]
    end

    it "sort_cost_benefit_INTERNOS" do
      groups = GoogleAds::CostBenefit.new.by_tag('[INTERNOS]')
      result = [
          {id_video_principal:'v11',cost_benefit:6.4},
          {id_video_principal:'v8',cost_benefit:5.64}
      ]

      expect(groups.first).to eq(result.first)
      expect(groups.last).to eq(result.last)
    end

    it "sort_cost_benefit_Garanhoes" do
      groups = GoogleAds::CostBenefit.new.by_tag('[G]')
      result = [
          {id_video_principal:'v11',cost_benefit:7.24},
          {id_video_principal:'v6',cost_benefit:5.06}
      ]

      expect(groups.first).to eq(result.first)
      expect(groups.last).to eq(result.last)
    end

    it "with_cost_and_sorted_by_cost" do
      groups = GoogleAds::CostBenefit.new.with_cost_per_video(sort_increasing: true)
      result = [
        {id_video_principal: 'v7', cost: 77.52,cost_benefit: 5.5},
        {id_video_principal: 'v17', cost: 3.22,cost_benefit: 6.22}
      ]

      expect(groups.first).to eq(result.first)
      expect(groups.last).to eq(result.last)
    end

  end
end