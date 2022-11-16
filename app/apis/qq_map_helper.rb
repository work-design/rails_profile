module QqMapHelper
  KEY = Rails.application.credentials.dig(:qq_map, :ws)
  SK = Rails.application.credentials.dig(:qq_map, :sk)
  BASE = 'https://apis.map.qq.com/'
  extend self

  def client
    return @client if defined? @client
    @client = HTTPX.with(origin: BASE, debug: STDERR, debug_level: 2)
  end

  def geocoder(lat:, lng:)
    url = 'ws/geocoder/v1'
    body = {
      key: KEY,
      location: [lat, lng].join(',')
    }
    binding.b
    r = client.get(url, params: params_with_sign(url, body))
    result = r.json
    if result['status'] == 0
      result['result']
    else
      Rails.logger.error(result)
      result
    end
  end

  def ip(ip)
    url = 'ws/location/v1/ip'
    body = {
      key: KEY,
      ip: ip
    }

    r = client.get(url, params: params_with_sign(url, body))
    result = r.json
    if result['status'] == 0
      result['result']
    else
      Rails.logger.error(result)
      result
    end
  end

  def districts
    url = 'ws/district/v1/list'
    body = {
      key: KEY
    }

    r = client.get(url, params: params_with_sign(url, body))
    result = r.json
    if result['status'] == 0
      result['result']
    else
      Rails.logger.error(result)
      result
    end
  end

  def params_with_sign(path, body)
    r = body.sort.map(&->(i){ "#{i[0]}=#{i[1]}" }).join('&')

    body.merge! sig: Digest::MD5.hexdigest("/#{path}?#{r}#{SK}")
  end

  def sync_to_areas
    results = districts
    results[0].each do |result|
      area = Profiled::Area.find_or_initialize_by(name: result['name'])
      area.full = result['fullname']
      area.code = result['id']
      area.save
    end

    results[1].each do |result|
      area = Profiled::Area.find_or_initialize_by(name: result['name'])
      parent = Profiled::Area.find_by(code: "#{result['id'][0..1]}0000")
      area.parent = parent
      area.full = result['fullname']
      area.code = result['id']
      area.save
    end

    results[2].each do |result|
      area = Profiled::Area.find_or_initialize_by(name: result['fullname'])
      parent = Profiled::Area.find_by(code: "#{result['id'][0..3]}00")
      area.parent = parent
      area.full = result['fullname']
      area.code = result['id']
      area.save
    end
  end

end
