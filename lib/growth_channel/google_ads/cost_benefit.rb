require_relative '../video/video_ads'

module GoogleAds
  # this class calculate the score of benefit cost
  class CostBenefit < Video::Video_ads

    def by_tag(tag, sorted: true)
      per_video(sort_increasing: sorted, filter_tag: tag)
    end

    def per_video(sort_increasing: false, filter_tag: '')
      group_videos = []
      group_main_video_info(filter_tag: filter_tag).each do |video|
        id_video_principal = video[:id_video_principal]
        group_videos.push({id_video_principal: id_video_principal, cost_benefit: calculate_benefit_cost(video)})
      end
      sort_increasing ? group_videos.sort_by { |element| element[:cost_benefit] }.reverse : group_videos
    end

    def with_cost_per_video(sort_increasing: false, filter_tag: '')
      group_videos = []
      group_main_video_info(filter_tag: filter_tag).each do |video|
        id_video_principal = video[:id_video_principal]
        cost = video[:cost].floor(2)
        group_videos.push({id_video_principal: id_video_principal, cost: cost, cost_benefit: calculate_benefit_cost(video)})
      end
      sort_increasing ? group_videos.sort_by { |element| element[:cost] }.reverse : group_videos
    end

    private

    def calculate_benefit_cost(video)
      cost_benefit = video[:views] + (video[:watched_25] * 2) + (video[:watched_50] * 4) + (video[:watched_75] * 5) + (video[:watched_100] * 3)
      cost_benefit /= 15 # soma dos pesos
      cost_benefit /= video[:cost]
      cost_benefit.floor(2)
    end
  end
end
