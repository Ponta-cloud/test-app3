require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"


# Time クラスの拡張を利用するため ActiveSupport を require する
require 'active_support/core_ext/time'

# 時刻の文字列を日本時間で解釈して、システムのタイムゾーンに変換
def jst(time)
  Time.zone = 'Asia/Tokyo'
  Time.zone.parse(time).localtime($system_utc_offset)
end

# 日本時間の 午前 7:00のバッチをスケジュール
every 1.day, at: jst('12:40 pm') do
  runner 'BlueshipUrls.blueship_url'
end