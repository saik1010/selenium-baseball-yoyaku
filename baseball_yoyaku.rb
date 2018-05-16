require 'capybara/rspec'

# seleniumでchoromeを使用する
Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

# ブラウザサイズを最大化
RSpec.configure do |config|
    config.before(:all) do
      screen_height = Capybara.page.execute_script("return screen.height;")
      screen_width = Capybara.page.execute_script("return screen.width;")
      Capybara.page.driver.browser.manage.window.move_to(0, 0)
      Capybara.page.driver.browser.manage.window.resize_to(screen_width, screen_height)
    end
end

feature 'Cabybaraのサンプル' do
    scenario 'CVすること' do

        # ログイン
        visit 'https://web101.rsv.ws-scs.jp/minato/web/'
        # click_on '施設の空き状況'
        fill_in('userId', with: 'IDを入力します')
        fill_in('password', with: 'パスワードを入力します')

        # 予約操作
        click_on 'ログイン'
        click_on '予約の申込み'
        click_on '利用目的から'
        click_on '屋外スポーツ（屋外競技）'
        click_on '軟式野球'
        click_on 'すべて'
        click_on 'すべて'

        # 空き状況をキャプチャ
        save_screenshot('azabu1.png')
        click_on '次の月'  
        save_screenshot('azabu2.png')
        click_on '次の月'
        save_screenshot('azabu3.png')
        click_on '次の施設'
        save_screenshot('aoyama3.png')
        click_on '前の月'
        save_screenshot('aoyama2.png')
        click_on '前の月'
        save_screenshot('aoyama1.png')
        sleep(5)
    end
end