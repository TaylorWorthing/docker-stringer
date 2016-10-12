require 'rufus/scheduler'
require 'rubygems'

scheduler = Rufus::Scheduler.new

scheduler.interval(ENV['STRINGER_FETCH_INTERVAL'] || '10m') do
  system "bundle exec rake -f Rakefile fetch_feeds"
end

scheduler.interval(ENV['STRINGER_CLEANUP_INTERVAL'] || '30d') do
  system "bundle exec rake -f Rakefile cleanup_old_stories"
end

scheduler.join
