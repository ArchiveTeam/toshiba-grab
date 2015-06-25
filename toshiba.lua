dofile("urlcode.lua")
dofile("table_show.lua")

local url_count = 0
local tries = 0
local item_type = os.getenv('item_type')
local item_value = os.getenv('item_value')

local downloaded = {}
local addedtolist = {}

-- Do not download following urls:
downloaded["http://support.toshiba.com/css/support/frontend/resets.dev.css?version=9"] = true
downloaded["http://support.toshiba.com/css/support/frontend/global.css?version=9"] = true
downloaded["http://support.toshiba.com/css/support/jquery.ui.css?version=9"] = true
downloaded["http://support.toshiba.com/css/support/frontend/shop-global.css?version=9"] = true
downloaded["http://support.toshiba.com/css/support/global-overrides.css?version=9"] = true
downloaded["http://support.toshiba.com/css/support/frontend/navshell.css?version=9"] = true
downloaded["http://support.toshiba.com/js/support/frontend/jquery-1.8.1.min.js?version=9"] = true
downloaded["http://support.toshiba.com/js/support/frontend/jquery-ui-1.8.23.custom.min.js?version=9"] = true
downloaded["http://support.toshiba.com/js/third-party/jQuery/hoverIntent/jquery.hoverIntent.minified.js?version=9"] = true
downloaded["http://support.toshiba.com/js/support/frontend/jquery.simplemodal.js?version=9"] = true
downloaded["http://support.toshiba.com/js/support/frontend/global.js?version=9"] = true
downloaded["http://support.toshiba.com/js/support/common/support.cookie.js?version=9"] = true
downloaded["http://support.toshiba.com/js/support/frontend/shop-global.js?version=9"] = true
downloaded["http://support.toshiba.com/images/support/frontend/toshLogo.gif"] = true
downloaded["https://ssl.google-analytics.com/ga.js"] = true
downloaded["http://support.toshiba.com/images/support/frontend/showcase/ui/navline.gif"] = true
downloaded["http://support.toshiba.com/images/support/frontend/showcase/ui/nav/nav-bg.png"] = true
downloaded["http://support.toshiba.com/images/support/frontend/showcase/ui/nav/nav-default-left.png"] = true
downloaded["http://support.toshiba.com/images/support/frontend/showcase/ui/nav/nav-default-right.png"] = true
downloaded["http://support.toshiba.com/images/support/frontend/showcase/ui/nav/nav-dropdown-bg.png"] = true
downloaded["http://support.toshiba.com/images/support/frontend/showcase/ui/nav/red-repeat.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/nav/nav-left-bg-hover.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/nav/nav-bg-selected.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/nav/nav-left-bg-selected.jpg"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/nav/nav-bg-main.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/nav/nav-seperator.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/nav/dropdown-bg-big.jpg"] = true
downloaded["http://support.toshiba.com/css/support/frontend/images/showcase/ui/nav/sub/active-bg.gif"] = true
downloaded["http://support.toshiba.com/images/support/frontend/showcase/ui/nav/sub/active-bg.gif"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/nav/nav-active-bg.gif"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/nav/search-results-selected-bg.jpg"] = true
downloaded["http://support.toshiba.com/images/support/frontend/showcase/ui/nav/body-bg.png"] = true
downloaded["http://support.toshiba.com/images/support/frontend/showcase/ui/series-nav-top-bg.jpg"] = true
downloaded["http://support.toshiba.com/images/support/frontend/common/vertLineSepFadeDown.gif"] = true
downloaded["http://support.toshiba.com/images/support/frontend/common/horizLineSep_720.gif"] = true
downloaded["http://support.toshiba.com/images/support/frontend/bullet_bk_sm.png"] = true
downloaded["http://support.toshiba.com/images/support/frontend/common/bulletIcon.jpg"] = true
downloaded["http://support.toshiba.com/images/support/frontend/mastersprite.png"] = true
downloaded["http://support.toshiba.com/images/support/frontend/acclaim_logo_30.png"] = true
downloaded["http://support.toshiba.com/images/support/frontend/showcase/ui/bg-grad-line-fade-1000.png"] = true
downloaded["http://support.toshiba.com/images/support/frontend/showcase/ui/footer-bg-strip.png"] = true
downloaded["http://support.toshiba.com/images/support/frontend/stripesidebar.png"] = true
downloaded["http://support.toshiba.com/images/support/frontend/stripegrey.png"] = true
downloaded["http://support.toshiba.com/images/support/frontend/stripesidebaractive.png"] = true
downloaded["http://support.toshiba.com/images/support/frontend/stripegreyactive.png"] = true
downloaded["http://support.toshiba.com/images/support/frontend/stripetabs2.png"] = true
downloaded["http://support.toshiba.com/images/support/frontend/datepicker/images/ui-bg_flat_0_aaaaaa_40x100.png"] = true
downloaded["http://support.toshiba.com/images/support/jquery-ui/ui-bg_content.png"] = true
downloaded["http://support.toshiba.com/images/support/jquery-ui/ui-bg_highlight-soft_15_cc0000_1x100.png"] = true
downloaded["http://support.toshiba.com/images/support/jquery-ui/ui-bg_highlight-hard_100_eeeeee_1x100.png"] = true
downloaded["http://support.toshiba.com/images/support/jquery-ui/ui-bg_highlight-hard_100_f6f6f6_1x100.png"] = true
downloaded["http://support.toshiba.com/images/support/jquery-ui/ui-bg_glass_55_fbf8ee_1x400.png"] = true
downloaded["http://support.toshiba.com/images/support/jquery-ui/ui-bg_diagonals-thick_55_eee7e7_40x40.png"] = true
downloaded["http://support.toshiba.com/images/support/jquery-ui/ui-icons_cc0000_256x240.png"] = true
downloaded["http://support.toshiba.com/images/support/jquery-ui/ui-icons_ffffff_256x240.png"] = true
downloaded["http://support.toshiba.com/images/support/jquery-ui/ui-icon-triangle-1-e.png"] = true
downloaded["http://support.toshiba.com/images/support/jquery-ui/ui-icon-triangle-1-s.png"] = true
downloaded["http://support.toshiba.com/images/support/jquery-ui/ui-icons_004276_256x240.png"] = true
downloaded["http://support.toshiba.com/images/support/jquery-ui/ui-bg_dots-small_65_a6a6a6_2x2.png"] = true
downloaded["http://support.toshiba.com/images/support/jquery-ui/ui-bg_flat_0_333333_40x100.png"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/header-grad-bg.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/link-grad-sep.png"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/view-cart-bg.png"] = true
downloaded["http://support.toshiba.com/images/shop/brand-logos/toshiba-logo-white.png"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/search-bg.png"] = true
downloaded["http://support.toshiba.com/images/shop/buttons/search-btn.png"] = true
downloaded["http://support.toshiba.com/images/shop/buttons/search-btn-active.png"] = true
downloaded["http://support.toshiba.com/images/shop/buttons/live-chat-btn.png"] = true
downloaded["http://support.toshiba.com/images/shop/buttons/live-chat-btn-active.png"] = true
downloaded["http://support.toshiba.com/images/shop/buttons/contact-us-btn.png"] = true
downloaded["http://support.toshiba.com/images/shop/buttons/contact-us-btn-active.png"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/main-nav-bg-active.png"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/main-nav-bg-specials-active.png"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/top-nav-sub-grad-bg.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/page-main-shadow-bg.png"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/bread-grad-bg.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/black-bar-bg.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/blue-grad-bg-btn.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/blue-grad-bg-btn-active.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/red-bg-btn.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/red-bg-btn-active.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/red-grad-bg-btn-30pxH.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/red-grad-bg-btn-30pxH-active.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/olive-btn-bg.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/olive-btn-bg-active.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/teal-btn-bg.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/teal-btn-bg-active.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/overlay-mask.png"] = true
downloaded["http://support.toshiba.com/images/shop/buttons/overlay-close.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-980.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-980.jpg"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-960.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-960.jpg"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-940.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-940.jpg"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-920.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-920.jpg"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-610.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-610.jpg"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-580.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-580.jpg"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-464.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-464.jpg"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-460.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-460.jpg"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-420.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-420.jpg"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-340.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-340.jpg"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-317.png"] = true
downloaded["http://support.toshiba.com/images/showcase/ui/bg-grad-line-fade-317.jpg"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/tab-bg.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/tab-bg-hover.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/tab-bg-active.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/slider-nav.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/slider-nav-active.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/gray-grad-bg-200pxH.gif"] = true
downloaded["http://support.toshiba.com/images/shop/icons/red-bullet.gif"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/gray-grad-bg-140pxH.gif"] = true
downloaded["http://support.toshiba.com/images/showcase/link-boxes/blank-box-big-mid.png"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/sitemap-grad-bg.gif"] = true
downloaded["http://support.toshiba.com/images/shop/buttons/signup-btn.png"] = true
downloaded["http://support.toshiba.com/images/shop/buttons/signup-btn-active.png"] = true
downloaded["http://support.toshiba.com/images/shop/icons/social-icons.png"] = true
downloaded["http://support.toshiba.com/images/shop/backgrounds/copyright-grad-bg.gif"] = true
downloaded["http://support.toshiba.com/images/shop/buttons/site-feedback-btn2.png"] = true

read_file = function(file)
  if file then
    local f = assert(io.open(file))
    local data = f:read("*all")
    f:close()
    return data
  else
    return ""
  end
end

wget.callbacks.download_child_p = function(urlpos, parent, depth, start_url_parsed, iri, verdict, reason)
  local url = urlpos["url"]["url"]
  local html = urlpos["link_expect_html"]
  
  if downloaded[url] == true or addedtolist[url] == true then
    return false
  end
  
  if (downloaded[url] ~= true or addedtolist[url] ~= true) then
    if string.match(urlpos["url"]["host"], "toshiba%.com") and string.match(url, "[^0-9]"..item_value.."[a-z0-9][a-z0-9]") and not string.match(url, "[^0-9]"..item_value.."[a-z0-9][a-z0-9][a-z0-9]") then
      addedtolist[url] = true
      return true
    elseif html == 0 then
      addedtolist[url] = true
      return true
    else
      return false
    end
  end
end


wget.callbacks.get_urls = function(file, url, is_css, iri)
  local urls = {}
  local html = nil

  if downloaded[url] ~= true then
    downloaded[url] = true
  end
 
  local function check(url)
    if (downloaded[url] ~= true and addedtolist[url] ~= true) and (string.match(url, "https?://cdgenp01%.csd%.toshiba%.com/") or (string.match(string.match(url, "https?://([^/]+)"), "toshiba%.com") and string.match(url, "[^0-9]"..item_value.."[a-z0-9][a-z0-9]") and not string.match(url, "[^0-9]"..item_value.."[a-z0-9][a-z0-9][a-z0-9]"))) then
      if string.match(url, "&amp;") then
        table.insert(urls, { url=string.gsub(url, "&amp;", "&") })
        addedtolist[url] = true
        addedtolist[string.gsub(url, "&amp;", "&")] = true
      else
        table.insert(urls, { url=url })
        addedtolist[url] = true
      end
    end
  end
  
  if string.match(string.match(url, "https?://([^/]+)/"), "toshiba%.com") and string.match(url, "[^0-9]"..item_value.."[a-z0-9][a-z0-9]") and not (string.match(url, "[^0-9]"..item_value.."[a-z0-9][a-z0-9][a-z0-9]") or string.match(url, "https?://cdgenp01%.csd%.toshiba%.com/")) then
    html = read_file(file)
    for newurl in string.gmatch(html, '"(https?://[^"]+)"') do
      check(newurl)
    end
    for newurl in string.gmatch(html, '("/[^"]+)"') do
      if string.match(newurl, '"//') then
        check(string.gsub(newurl, '"//', 'http://'))
      elseif not string.match(newurl, '"//') then
        check(string.match(url, "(https?://[^/]+)/")..string.match(newurl, '"(/.+)'))
      end
    end
    for newurl in string.gmatch(html, "('/[^']+)'") do
      if string.match(newurl, "'//") then
        check(string.gsub(newurl, "'//", "http://"))
      elseif not string.match(newurl, "'//") then
        check(string.match(url, "(https?://[^/]+)/")..string.match(newurl, "'(/.+)"))
      end
    end
  end
  
  return urls
end
  

wget.callbacks.httploop_result = function(url, err, http_stat)
  -- NEW for 2014: Slightly more verbose messages because people keep
  -- complaining that it's not moving or not working
  status_code = http_stat["statcode"]
  
  url_count = url_count + 1
  io.stdout:write(url_count .. "=" .. status_code .. " " .. url["url"] .. ".  \n")
  io.stdout:flush()

  if (status_code >= 200 and status_code <= 399) then
    if string.match(url.url, "https://") then
      local newurl = string.gsub(url.url, "https://", "http://")
      downloaded[newurl] = true
    else
      downloaded[url.url] = true
    end
  end
  
  if status_code >= 500 or
    (status_code >= 400 and status_code ~= 404 and status_code ~= 403) then

    io.stdout:write("\nServer returned "..http_stat.statcode..". Sleeping.\n")
    io.stdout:flush()

    os.execute("sleep 10")

    tries = tries + 1

    if tries >= 6 then
      io.stdout:write("\nI give up...\n")
      io.stdout:flush()
      tries = 0
      return wget.actions.ABORT
    else
      return wget.actions.CONTINUE
    end
  elseif status_code == 0 then

    io.stdout:write("\nServer returned "..http_stat.statcode..". Sleeping.\n")
    io.stdout:flush()

    os.execute("sleep 10")
    
    tries = tries + 1

    if tries >= 6 then
      io.stdout:write("\nI give up...\n")
      io.stdout:flush()
      tries = 0
      return wget.actions.ABORT
    else
      return wget.actions.CONTINUE
    end
  end

  tries = 0

  local sleep_time = 0

  if sleep_time > 0.001 then
    os.execute("sleep " .. sleep_time)
  end

  return wget.actions.NOTHING
end
