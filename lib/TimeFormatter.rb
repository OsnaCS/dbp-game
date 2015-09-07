def format_count_time(secs)
	day = secs / (60 * 60* 24)
    hour = secs / (60 * 60) % 24
	min = (secs / 60) % 60
	sec = secs % 60

	return day.to_i.to_s + ":" + hour.to_i.to_s + ":" + min.to_i.to_s + ":" + sec.to_i.to_s
end