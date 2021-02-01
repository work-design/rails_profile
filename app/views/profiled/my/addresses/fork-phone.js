import { Controller } from 'stimulus'

class WechatAddressController extends Controller {

  connect() {
    console.debug('Wechat Address Controller works!')
    wx.ready(() => {
      this.openAddress()
    })
    this.openAddress()
  }

  close() {
    wx.closeWindow()
  }

  openAddress() {
    wx.openAddress({
      success: (res) => {
        alert(res)
        document.getElementById('address_contact').value = res.userName
        document.getElementById('address_tel').value = res.telNumber
        document.getElementById('address_detail').value = res.detailInfo
        document.getElementById('address_post_code').value = res.postalCode
        document.getElementById('province_name').value = res.provinceName
        document.getElementById('city_name').value = res.cityName
        document.getElementById('country_name').value = res.countryName
      }
    })
  }

}

application.register('wechat_address', WechatAddressController)
