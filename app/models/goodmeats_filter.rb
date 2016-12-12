class GoodmeatsFilter
  def filter(results)
    results.select do |result|
      goodmeat?(result)
    end
  end

  private

  def goodmeat_api_ids
    @_goodmeat_api_ids ||=
      Restaurant.order(:api_id).pluck(:api_id)
  end

  def goodmeat?(result)
    goodmeat_api_ids.include?(result.api_id)
  end
end
