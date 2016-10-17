Slugs.configure do |config|
  config.use_slug_proc = Proc.new do |record, params|
    true
  end
end
