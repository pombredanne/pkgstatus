class Metrics::Repository::StarMetric < ::Metric
  def self.name
    'GitHub Stars'
  end

  def value
    source.repository[:stargazers_count]
  end
end
