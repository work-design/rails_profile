module QqMapHelper
  KEY = Rails.application.credentials.dig(:qq_map, :ws)
  extend self

  def geocoder(lat:, lng:)
    url = 'https://apis.map.qq.com/ws/geocoder/v1'
    body = {
      key: KEY,
      location: [lat, lng].join(',')
    }

    r = HTTPX.get(url, params: body)
    result = JSON.parse(r.to_s)
    if result['status'] == 0
      result['result']
    else
      result
    end
  end

  def ip(ip)
    url = 'https://apis.map.qq.com/ws/location/v1/ip'
    body = {
      key: KEY,
      ip: ip
    }

    r = HTTPX.get(url, params: body)
    result = JSON.parse(r.to_s)
    if result['status'] == 0
      result['result']
    else
      result
    end
  end

  def districts
    url = 'https://apis.map.qq.com/ws/district/v1/list'
    body = {
      key: KEY
    }

    r = HTTPX.get(url, params: body)
    result = JSON.parse(r.to_s)
    if result['status'] == 0
      result['result']
    else
      result
    end
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
      area = Profiled::Area.find_or_initialize_by(name: result['name'])
      parent = Profiled::Area.find_by(code: "#{result['id'][0..3]}00")
      area.parent = parent
      area.full = result['fullname']
      area.code = result['id']
      area.save
    end
  end

end
