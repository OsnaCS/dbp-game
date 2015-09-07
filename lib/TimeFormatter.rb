def format_count_time(secs)
	day = secs / (60 * 60* 24)
    hour = secs / (60 * 60) % 24
	min = (secs / 60) % 60
	sec = secs % 60

	return (day < 10 ? "0" : "") + day.to_i.to_s + ":" + (hour < 10 ? "0" : "") + hour.to_i.to_s + ":" + 
	(min < 10 ? "0" : "") + min.to_i.to_s + ":" + (sec < 10 ? "0" : "") + sec.to_i.to_s
end