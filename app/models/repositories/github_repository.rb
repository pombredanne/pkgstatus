class Repositories::GithubRepository < ::Repository
  def self.metric_classes
    [
      Metrics::Repository::StarMetric,
      Metrics::Repository::LastCommitMetric,
    ]
  end

  # FIXME:
  #   uri -> owner/repo slug
  def slug
    'meganemura/codestatus'
  end

  def repository
    @repository ||= begin
                      # Sawyer::Resource -> Hash
                      client.repository(slug).to_hash
                    rescue Octokit::NotFound
                      nil
                    end
  end

  def last_commit
    @last_commit ||= begin
                       client.commits(slug, per_page: 1).first.to_hash
                     rescue Octokit::NotFound
                       nil
                     end
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: access_token)
  end

  def access_token
    ENV['PKGSTATUS_GITHUB_TOKEN']
  end
end
