const redirects = {};

function mapRedirect(ids, value) {
    ids.forEach(id => {
        redirects[id] = value;
    });
}
// Mains Events Live Leagues
mapRedirect(["serie-a-live", "876933"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/bilalimages/banners/16994253041673x672.jpg",
    title: "Watch Serie A Live",
    video: "football-live/serie-a-live.html"
}),
    mapRedirect(["ufc-fight-live"], {
        splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/17114353671020x576.jpg",
        title: "Watch UFC Fight Live",
        video: "series.html?source=https://awstapmadstreaming.akamaized.net/hls/live/2095955/epl2fg4E/master.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=UFC Fight Live&subcode=en&substitleurl=substitles/series-sub.srt&img=https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/17114353671020x576.jpg"
    });
mapRedirect(["pak-vs-eng-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/bilalimages/banners/17162797811673.jpg",
    title: "Watch Pakistan Vs England Match Live",
    video: "series.html?source=https://tencentscdn.tamashaweb.com/v1/0188b99654681eb401a6029b3603/0188b9979aad1eb401a6029b3606/testmain.m3u8?uuid=FFAAFFFF-49eb-73f1-7421-e67b1adcca32&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Pak%20Vs%20Eng%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/ChannelFeaturedWebthumb/17159305511020x576.jpg",
});
mapRedirect(["pakw-vs-engw-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/bilalimages/banners/17153996521673x672_.jpg",
    title: "Watch Pakistan Vs England Women's Match Live",
    video: "series.html?source=https://premierleageplnew2.akamaized.net/hls/live/2107109/TAp2Yt7ji/master.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Pak%20Vs%20Eng%20W%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/17153994171020x576.jpg",
});
mapRedirect(["ipl-17-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/bilalimages/banners/17109188381673x672_.jpg",
    title: "Watch Indian Premier League Season 17 Live",
    video: "series.html?source=https://tencentscdn.tamashaweb.com/v1/0188b99654681eb401a6029b3603/0188b9979aad1eb401a6029b3606/testmain.m3u8?uuid=FFAAFFFF-49eb-73f1-7421-e67b1adcca32&subcode=en&substitleurl=substitles/series-sub.srt&title-1=IPL%2017%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/ChannelFeaturedWebthumb/17109182521020x576.jpg",
});
//Live Channels
mapRedirect(["ten-sports-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16763540731020x576.jpg",
    title: "Watch Ten Sports Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/tensports.smil/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Ten Sports Live&subcode=en&substitleurl=substitles/series-sub.srt&img=https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16763540731020x576.jpg"
});
mapRedirect(["euro-sports-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16696376061020x576.jpg",
    title: "Watch Euro Sports Live",
    video: "series.html?source=https%3A%2F%2Ftapmadlive.akamaized.net%2Ftapmadold%2Feurosports.smil%2Fplaylist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Euro%20Sports%20Live%20By%20H.A&subcode=en&substitleurl=substitles/series-sub.srt&img=https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16696376061020x576.jpg"
});
mapRedirect(["m-1-mma-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/1623143953M-1Thumbs--02.jpg",
    title: "Watch M-1 MMA Live",
    video: "series.html?source=https%3A%2F%2Fhls-mma-tv.cdnvideo.ru%2Fmma-tv%2Fmmatv.smil%2Fplaylist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=M-1%20MMA%20Live%20By%20H.A&subcode=en&substitleurl=substitles/series-sub.srt&img=https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/1623143953M-1Thumbs--02.jpg"
});
mapRedirect(["sportal-tv-live"], {
    splashimgurl: "https://scontent.flhe5-1.fna.fbcdn.net/v/t39.30808-6/244992693_351810270070965_2275905946298378833_n.png?_nc_cat=101&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeEqB7nGhWo6KXbiA4hSUK1qUhFgO3GILFNSEWA7cYgsU2B01F1gqCrHtrLpe89fEain21gC_RgIdfI9cYRxa-0t&_nc_ohc=4XpiPadlY_0AX9HstBt&_nc_ht=scontent.flhe5-1.fna&oh=00_AfAzaLX_8oDQPs2Z-QKKgFrLB1MtEoQEQsavNjyWk2CtVQ&oe=660DF41A",
    title: "Watch Sportal TV Live",
    video: "https://sportal.bg/video_embed/aWQ9MjAyMTAzMTQxNjI0MzQ5OTk5OA=="
});
mapRedirect(["channel-sports-hd"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16715366111020x576.jpg",
    title: "Watch Channel Sports HD",
    video: "series.html?source=https%3A%2F%2Fchannel2.csports.tv%2F1672621854%2Ftracks-v3a1%2Fmono.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Channel%20Sports%20HD&subcode=en&substitleurl=substitles/series-sub.srt&img=https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16715366111020x576.jpg"
});
mapRedirect(["ary-news-live"], {
    splashimgurl: "https://propakistani.pk/how-to/wp-content/uploads/2022/12/ary-news-live.jpg",
    title: "Watch Ary News Live",
    video: "https://www.youtube.com/embed/sUKwTVAc0Vo?autoplay=1&mute=0"
});
mapRedirect(["geo-news-live"], {
    splashimgurl: "https://www.thenews.com.pk//assets/uploads/updates/2019-07-24/503010_3171329_geo-news_updates.jpg",
    title: "Watch Geo News Live",
    video: "series.html?source=https://jk3lz82elw79-hls-live.5centscdn.com/GEONEWS/3500ba09d0538297440ca620c9dd46bf.sdp/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Geo%20News%20Live&img=https://i.pinimg.com/originals/e3/19/c2/e319c221bd0fb015c590002cfc31fac8.jpg"
});
mapRedirect(["bol-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16419845783.jpg",
    title: "Watch Bol News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/bolnews.smil/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Bol%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16419845783.jpg"
});
mapRedirect(["hum-news-live"], {
    splashimgurl: "https://www.bizasialive.com/wp-content/uploads/2018/05/hum-news002-1200x600.jpg",
    title: "Watch Hum News Live",
    video: "https://www.youtube.com/embed/HkgBiWCXikY?autoplay=1&mute=0"
});
mapRedirect(["dawn-news-live"], {
    splashimgurl: "https://media.licdn.com/dms/image/C561BAQFBCDoVrBcEUQ/company-background_10000/0/1624345731325/dawnnews_tv_cover?e=2147483647&v=beta&t=qDTzlvj-kqOCSXQ76Pp4X5O7odypNduvcJJjbD6867w",
    title: "Watch Dawn News Live",
    video: "https://www.youtube.com/embed/etdhvCStLzU?autoplay=1&mute=0"
});
mapRedirect(["express-news-live"], {
    splashimgurl: "https://i.ytimg.com/vi/RFGvhJe8A_o/maxresdefault.jpg",
    title: "Watch Express News Live",
    video: "https://www.youtube.com/embed/hqAW0iMUQQo?autoplay=1&mute=0"
});
mapRedirect(["92-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/92_news.jpg",
    title: "Watch 92 News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/92news.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=92%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/92_news.jpg"
});
mapRedirect(["samaa-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/1633512222d2c3b-samaa_1080_by_605.jpg",
    title: "Watch Samaa News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/saamanews.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Samaa%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/1633512222d2c3b-samaa_1080_by_605.jpg"
});
mapRedirect(["24-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/channel_24_news.jpg",
    title: "Watch 24 News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/channel24.smil/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=24%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/channel_24_news.jpg"
});
mapRedirect(["gnn-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/99a80-gnn-3.jpg",
    title: "Watch Gnn News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/jaagtv.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Gnn%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/99a80-gnn-3.jpg"
});
mapRedirect(["neo-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/neo.jpg",
    title: "Watch Neo News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/neo.smil/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Neo%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/neo.jpg"
});
mapRedirect(["aaj-news-live"], {
    splashimgurl: "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/8a86ce71-3de0-42d8-b54c-8f65a2fafe57/d21aly0-453f4ee9-e369-4f74-b4e3-b846745b2605.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzhhODZjZTcxLTNkZTAtNDJkOC1iNTRjLThmNjVhMmZhZmU1N1wvZDIxYWx5MC00NTNmNGVlOS1lMzY5LTRmNzQtYjRlMy1iODQ2NzQ1YjI2MDUuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.zUHkXG_1EJRacB2-EiiSPRtwohUFxcr_tpzmbkCHnTo",
    title: "Watch Aaj News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/aajnews.smil/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Aaj%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16113171191020x576.jpg"
});
mapRedirect(["city42-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/city_42_news.jpg",
    title: "Watch City 42 News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/city42.smil/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=City%2042%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/city_42_news.jpg"
});
mapRedirect(["metro-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/metro_one_news.jpg",
    title: "Watch Metro News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/metro.smil/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Metro%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/metro_one_news.jpg"
});
//World News Channel
mapRedirect(["cnn-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/366f4-cnn-3.jpg",
    title: "Watch CNN News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/cnn.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=CNN%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/366f4-cnn-3.jpg"
});
mapRedirect(["bbc-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/bbc_world_news.jpg",
    title: "Watch BBC World News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/bbcnews.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=BBC%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/bbc_world_news.jpg"
});
mapRedirect(["al-jazeera-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/al_jazeerah.jpg",
    title: "Watch Al Jazeera News Live",
    video: "series.html?source=https://live-hls-web-aje.getaj.net/AJE/index.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Al%20Jazeera%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/al_jazeerah.jpg"
});
mapRedirect(["trt-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/67008-3-copy.jpg",
    title: "Watch TRT World News Live",
    video: "series.html?source=https://tv-trtworld.live.trt.com.tr/master.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=TRT%20World%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/67008-3-copy.jpg"
});
mapRedirect(["euro-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/7cd05-euro-news-title-high.jpg",
    title: "Watch Euro News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/euronews.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Euro%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/7cd05-euro-news-title-high.jpg"
});
mapRedirect(["dw-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/dw.jpg",
    title: "Watch DW News Live",
    video: "series.html?source=https://dwamdstream102.akamaized.net/hls/live/2015525/dwstream102/index.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=DW%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/dw.jpg"
});
mapRedirect(["voice-of-america-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/ec4e7-voice-of-america-high.jpg",
    title: "Watch Voice Of America News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/voa.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Voice%20Of%20America%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/ec4e7-voice-of-america-high.jpg"
});
//Entertainment Channels
mapRedirect(["hum-tv-live"], {
    splashimgurl: "https://vidly.tv/image/live_channels/hum.jpg",
    title: "Watch Hum TV Live",
    video: "https://iframes.5centscdn.com/5centscdn/hls/op2qya44ylz5/0yu28niow93uzm72/aHR0cHM6Ly9nNHdsa3d4OGwyM2EtaGxzLWxpdmUuNWNlbnRzY2RuLmNvbS9IVU0vMjcxZGRmODI5YWZlZWNlNDRkODczMjc1N2ZiYTFhNjYuc2RwL3BsYXlsaXN0X2R2ci5tM3U4?showcv=true&title=HUM/TV"
});
mapRedirect(["geo-entertainment-live"], {
    splashimgurl: "https://harpalgeo.tv/assets/front/images/programe_noimage.jpg",
    title: "Watch Geo Entertainment Live",
    video: "series.html?source=https://jk3lz82elw79-hls-live.5centscdn.com/harPalGeo/955ad3298db330b5ee880c2c9e6f23a0.sdp/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Geo%20Entertainment%20Live&img=https://harpalgeo.tv/assets/front/images/harpal_live.jpg"
});
mapRedirect(["bol-entertainment-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16419858523.jpg",
    title: "Watch Bol Entertainment Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/bolent.smil/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Bol%20Entertainment%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16419858523.jpg"
});
mapRedirect(["green-entertainment-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16419858523.jpg",
    title: "Watch Green Entertainment Live",
    video: "https://play.shoq.com.pk/en/movies/green-tv-live/469871144207"
});
mapRedirect(["express-entertainment-live"], {
    splashimgurl: "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/43cd6a20533191.562ecde0c384f.png",
    title: "Watch Express Entertainment Live",
    video: "series.html?source=https://5dcabf026b188.streamlock.net/expressdigital/livestream/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Express%20Entertainment%20Live&img=https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/43cd6a20533191.562ecde0c384f.png"
});
mapRedirect(["a-plus-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/a_plus.jpg",
    title: "Watch A Plus Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/aplus.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=A%20Plus%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/a_plus.jpg"
});
mapRedirect(["film-world-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/film_world.jpg",
    title: "Watch Film World Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/filmworld.smil/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Film%20World%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/film_world.jpg"
});
mapRedirect(["play-entertainment-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/447c0-play-ent-title-high.jpg",
    title: "Watch Play Entertainment Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/playmax.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Play%20Entertainment%20Live&img=https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelThumbnailPath/2d8e3-play-ent-title-web.jpg"
});
mapRedirect(["atv-entertainment-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/atv.jpg",
    title: "Watch ATV Entertainment Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/atv.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=ATV%20Entertainment%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/atv.jpg"
});
// Reality & Learnings Live Channels
mapRedirect(["discover-pakistan-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16248919481020x576.jpg",
    title: "Watch Discover Pakistan Live",
    video: "series.html?source=https://livecdn.live247stream.com/discoverpakistan/tapmad/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Discover%20Pakistan%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16248919481020x576.jpg"
});
mapRedirect(["discovery-channel-live"], {
    splashimgurl: "",
    title: "Watch Discovery Channel Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/discovery.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Discovery%20Channel%20Live&img="
});
mapRedirect(["motorvision-tv-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16113172021020x576.jpg",
    title: "Watch Motorvision TV Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/motorvision.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Motorvision%20TV%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/16113172021020x576.jpg"
});
mapRedirect(["outdoor-channel-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/15899698681020%20x%20576.jpg",
    title: "Watch Outdoor Channel Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/outdoornew.smil/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Outdoor%20Channel%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/15899698681020%20x%20576.jpg"
});
mapRedirect(["animal-planet-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/a4fc1-animal-planet-3.jpg",
    title: "Watch Animal Planet Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/animal.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Animal%20Planet%20Live&img=https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/a4fc1-animal-planet-3.jpg"
});
//Music Live Channels
mapRedirect(["8xm-music-live"], {
    splashimgurl: "https://scontent.flhe5-1.fna.fbcdn.net/v/t39.30808-6/339642132_752803656585210_1444469603716006993_n.png?_nc_cat=104&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeFH9QouXuygJ4HrjPCIzP4N3dKga8C-BH_d0qBrwL4Ef5UYrrOiYTl50ZnuGn9bNesl3zAKLHsySp9I3N98-nkx&_nc_ohc=JaiHx3SWV2UAX_lEsgf&_nc_ht=scontent.flhe5-1.fna&oh=00_AfAP3q6jWKaOne79lPUQyE0EzIWL3z2atJ0CfhYUGG8WAg&oe=660FC525",
    title: "Watch 8XM Music Live",
    video: "https://www.mjunoon.tv/embedplayer/8xm-live.html"
});
mapRedirect(["jalwa-tv-live"], {
    splashimgurl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJAOiLSOyAIZxai-sRNovsGaqyOHqIklCdmRdax4ixSIb5ZEUsGyWGato-S53QSvwCVg&usqp=CAU",
    title: "Watch Jalwa TV Live",
    video: "https://www.mjunoon.tv/embedplayer/jalwa-tv-live.html"
});
//Kids Live Channels
mapRedirect(["cartoon-network-english-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/29501-a5ee7-cartoon-network-3.jpg",
    title: "Watch Cartoon Network English Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/cartoon.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Cartoon%20Network%20English%20Live&img=https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/29501-a5ee7-cartoon-network-3.jpg"
});
mapRedirect(["cartoon-network-urdu-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/bc373-cartoon-network-3-in-urdu.jpg",
    title: "Watch Cartoon Network Urdu Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/cartoonhindi.smil/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Cartoon%20Network%20Urdu%20Live&img=https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/bc373-cartoon-network-3-in-urdu.jpg"
});
mapRedirect(["baby-tv-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/88170-baby-tv-3.jpg",
    title: "Watch Baby TV Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/babytv.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Baby%20TV%20Live&img=https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/88170-baby-tv-3.jpg",
});
mapRedirect(["discovery-kids-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/6d991-1080-x-576.jpg",
    title: "Watch Discovery Kids Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/discoverykids.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Discovery%20Kids%20Live&img=https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/6d991-1080-x-576.jpg",
});
//Islamic Channels Live
mapRedirect(["makkah-tv-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/1649059727Artboard2-100.jpg",
    title: "Watch Makkah TV Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/makkah.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Makkah%20TV%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/1649059727Artboard2-100.jpg",
});
mapRedirect(["madina-tv-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/1649059915Artboard2-100.jpg",
    title: "Watch Madina TV Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/madina.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Madina%20TV%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/mobile_large/1649059915Artboard2-100.jpg",
});
mapRedirect(["madani-tv-live"], {
    splashimgurl: "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/d2/0e/6a/d20e6acb-789c-e3d5-ff22-f2c9e87ef433/AppIcon-0-0-1x_U007emarketing-0-7-0-0-85-220.png/1200x630wa.png",
    title: "Watch Madani TV Live",
    video: "series.html?source=https://streaming.madanichannel.tv/static/streaming-playlists/hls/b9790f10-cb0d-4e30-82bf-84a756234e58/master.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Madani%20TV%20Live&img=https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/d2/0e/6a/d20e6acb-789c-e3d5-ff22-f2c9e87ef433/AppIcon-0-0-1x_U007emarketing-0-7-0-0-85-220.png/1200x630wa.png",
});
//Regional TV Live
mapRedirect(["khyber-entertainment-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/khyber_ent.jpg",
    title: "Watch Khyber Entertainment Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/khyber.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Khyber%20Entertainment%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/khyber_ent.jpg",
});
mapRedirect(["khyber-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/khyber_news.jpg",
    title: "Watch Khyber News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/khybernews.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Khyber%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/khyber_news.jpg",
});
mapRedirect(["k21-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/k_21_news.jpg",
    title: "Watch K21 News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/k21.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=K21%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/k_21_news.jpg",
});
mapRedirect(["kay2-entertainment-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/k_2_news.jpg",
    title: "Watch KAY2 Entertainment Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/k2.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=KAY2%20Entertainment%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/k_2_news.jpg",
});
mapRedirect(["koh-e-noor-tv-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/kohenoor_tv.jpg",
    title: "Watch Koh e noor TV Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/kohenoor.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Koh%203%20noor%20TV%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/kohenoor_tv.jpg",
});
mapRedirect(["mehran-tv-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/mehran.jpg",
    title: "Watch Mehran TV Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/mehran.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mehran%20TV%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/mehran.jpg",
});
mapRedirect(["dharti-tv-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/dharti_tv.jpg",
    title: "Watch Dharti TV Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/dhartitv.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Dharti%20TV%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/dharti_tv.jpg",
});
mapRedirect(["awaz-tv-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/images/channels/large/awaz_news.jpg",
    title: "Watch Awaz TV Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/awaztv.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Awaz%20TV%20Live&img=https://d34080pnh6e62j.cloudfront.net/images/channels/large/awaz_news.jpg",
});
mapRedirect(["vsh-news-live"], {
    splashimgurl: "https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/0b745-vsh-news-channel-title-high.jpg",
    title: "Watch Vsh News Live",
    video: "series.html?source=https://tapmadlive.akamaized.net/tapmadold/vsh.smil/playlist.m3u8?&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Vsh%20News%20Live&img=https://d34080pnh6e62j.cloudfront.net/adminpanel/assets/uploads/ChannelMobileLarge/0b745-vsh-news-channel-title-high.jpg",
});


//Movies
mapRedirect(["rich-in-love", "656563"], {
    splashimgurl: "https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/6AYY37jfdO6hpXcMjf9Yu5cnmO0/AAAABWPB3bKU8iPGHdR9D8ochEqkmoLFgl4mftdTGLq1QNjAIN44-nAiMT8_bF_ewMl_j4bFE3wyGiCaq79TSl_LAMdkvbQsrT44lRiV.jpg",
    title: "Watch Rich In Love",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/a00487daebf48eb4d4021cbead3a1af48d2884ca2b99652d75f1a6b52fdc04b4c9f0044ed64aec2b3cf742e24ef9a5e6964108d4bb658a696985325eecb61c1b208a866a8e7d6950efb65f815b5ba25c86c3137f841c55b86af56ad985885d14fc24a1e384836cd08939b58479d1fc8fe14f6ef5987956e9c88588abf8b9b05d04a9fd53b575ab512fe74f24cac5f022/playlist.m3u8&title-1=Rich%20In%20Love&img=https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/6AYY37jfdO6hpXcMjf9Yu5cnmO0/AAAABWPB3bKU8iPGHdR9D8ochEqkmoLFgl4mftdTGLq1QNjAIN44-nAiMT8_bF_ewMl_j4bFE3wyGiCaq79TSl_LAMdkvbQsrT44lRiV.jpg&duration=6324&subcode=en&substitleurl=substitles/Movies/Rich.In.Love/Rich.in.Love.WEBRip.Netflix.en.srt",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/a00487daebf48eb4d4021cbead3a1af48d2884ca2b99652d75f1a6b52fdc04b4c9f0044ed64aec2b3cf742e24ef9a5e6964108d4bb658a696985325eecb61c1b208a866a8e7d6950efb65f815b5ba25c86c3137f841c55b86af56ad985885d14fc24a1e384836cd08939b58479d1fc8fe14f6ef5987956e9c88588abf8b9b05d04a9fd53b575ab512fe74f24cac5f022/playlist.m3u8&title-1=Rich%20In%20Love&img=https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/6AYY37jfdO6hpXcMjf9Yu5cnmO0/AAAABWPB3bKU8iPGHdR9D8ochEqkmoLFgl4mftdTGLq1QNjAIN44-nAiMT8_bF_ewMl_j4bFE3wyGiCaq79TSl_LAMdkvbQsrT44lRiV.jpg&duration=6324&subcode=en&substitleurl=substitles/Movies/Rich.In.Love/Rich.in.Love.WEBRip.Netflix.en.srt",
});
mapRedirect(["rich-in-love-2", "1126852"], {
    splashimgurl: "https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/6AYY37jfdO6hpXcMjf9Yu5cnmO0/AAAABWPB3bKU8iPGHdR9D8ochEqkmoLFgl4mftdTGLq1QNjAIN44-nAiMT8_bF_ewMl_j4bFE3wyGiCaq79TSl_LAMdkvbQsrT44lRiV.jpg",
    title: "Watch Rich In Love 2",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/4068774d5c9a685e76a3a12d35c7a13ce2248412afa2dd042665f2feaf82bf9f9eace94736328c8145e727ca7ce3a42c08acf1aa6c59e958738040e5a7ee2c83453552b179e1edfbd5f187dc5058e960db598a9170ebb0754c0ccb60c402532a3c916ecae490c42f3248c0205c5fef4e9ab0708e24d9015e1e0a424aecb76fdc0b684a730f5fbcc2b3abd4e710b5c931/playlist.m3u8&title-1=Rich In Love 2&img=https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/6AYY37jfdO6hpXcMjf9Yu5cnmO0/AAAABWPB3bKU8iPGHdR9D8ochEqkmoLFgl4mftdTGLq1QNjAIN44-nAiMT8_bF_ewMl_j4bFE3wyGiCaq79TSl_LAMdkvbQsrT44lRiV.jpg&duration=5362&subcode=en&substitleurl=substitles/Movies/Rich.In.Love/Rich.In.Love.2.English-WWW.MY-SUBS.CO.srt",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/4068774d5c9a685e76a3a12d35c7a13ce2248412afa2dd042665f2feaf82bf9f9eace94736328c8145e727ca7ce3a42c08acf1aa6c59e958738040e5a7ee2c83453552b179e1edfbd5f187dc5058e960db598a9170ebb0754c0ccb60c402532a3c916ecae490c42f3248c0205c5fef4e9ab0708e24d9015e1e0a424aecb76fdc0b684a730f5fbcc2b3abd4e710b5c931/playlist.m3u8&title-1=Rich In Love 2&img=https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/6AYY37jfdO6hpXcMjf9Yu5cnmO0/AAAABWPB3bKU8iPGHdR9D8ochEqkmoLFgl4mftdTGLq1QNjAIN44-nAiMT8_bF_ewMl_j4bFE3wyGiCaq79TSl_LAMdkvbQsrT44lRiV.jpg&duration=5362&subcode=en&substitleurl=substitles/Movies/Rich.In.Love/Rich.In.Love.2.English-WWW.MY-SUBS.CO.srt",
});
mapRedirect(["jawani-phir-nahi-ani", "361759"], {
    splashimgurl: "https://filmnchips.files.wordpress.com/2018/10/jpna-2.jpg",
    title: "Watch Jawani Phir Nahi Ani 2",
    video: "jawani-phir-nahi-ani-2.html",
    video2: "jawani-phir-nahi-ani-2.html",
});
mapRedirect(["through-my-window", "818647"], {
    splashimgurl: "https://www.comingsoon.net/wp-content/uploads/sites/3/2024/01/Through-My-Window.jpg",
    title: "Watch Through My Window",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/a78882e2b13cc3e37140e1b3b831240d36037a230f1e8a651106b68df4309c6dff7f9341e120f82fe34c2825c0e6cb4f7a2ef35e09ee234007e389ecd199df5f97387f0aaf42c348e234d3c79a493be4ef7214521b81db6833f1c28b8257ef35b441fe25c0f6c31410315324a055f67ddda222cc1dd916d8b336c1b94a839bb65b6cb2cb7e6708101f393796448843f7/playlist.m3u8&title-1=Through My Window &img=https://www.comingsoon.net/wp-content/uploads/sites/3/2024/01/Through-My-Window.jpg&duration=6801&subcode=en&substitleurl=substitles/Movies/Through.My.Window/Through.My.Window.2022.DUBBED.1080p.WEBRip.x264-RARBG.srt",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/a78882e2b13cc3e37140e1b3b831240d36037a230f1e8a651106b68df4309c6dff7f9341e120f82fe34c2825c0e6cb4f7a2ef35e09ee234007e389ecd199df5f97387f0aaf42c348e234d3c79a493be4ef7214521b81db6833f1c28b8257ef35b441fe25c0f6c31410315324a055f67ddda222cc1dd916d8b336c1b94a839bb65b6cb2cb7e6708101f393796448843f7/playlist.m3u8&title-1=Through My Window &img=https://www.comingsoon.net/wp-content/uploads/sites/3/2024/01/Through-My-Window.jpg&duration=6801&subcode=en&substitleurl=substitles/Movies/Through.My.Window/Through.My.Window.2022.DUBBED.1080p.WEBRip.x264-RARBG.srt",
});
mapRedirect(["through-my-window-across-the-sea", "988078"], {
    splashimgurl: "https://ntvb.tmsimg.com/assets/p24155172_v_h8_ab.jpg",
    title: "Watch Through My Window: Across The Sea",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/c08130d8dda85f12a600651ad698ae79b1269f262f70f3b8e44184ba0fe7af53c362c72548d308fcb88c662958e46485198998534ee1a9a6ff8a5c365bea6a59407e652b82ba72652b50229ef613928f908c5022dfa58df5f0c88127f810bd052d17ade840b8f4a5db9617ed77539fd22812dc2ecaf841a4b078f4d4ffacb3d65f7176129d612b140dc100a8d3b2060f/playlist.m3u8&title-1=Through My Window 2&img=https://ntvb.tmsimg.com/assets/p24155172_v_h8_ab.jpg&duration=6702&subcode=en&substitleurl=substitles/Movies/Through.My.Window/Through.My.Window.Across.The.Sea.English-WWW.MY-SUBS.CO.srt",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/c08130d8dda85f12a600651ad698ae79b1269f262f70f3b8e44184ba0fe7af53c362c72548d308fcb88c662958e46485198998534ee1a9a6ff8a5c365bea6a59407e652b82ba72652b50229ef613928f908c5022dfa58df5f0c88127f810bd052d17ade840b8f4a5db9617ed77539fd22812dc2ecaf841a4b078f4d4ffacb3d65f7176129d612b140dc100a8d3b2060f/playlist.m3u8&title-1=Through My Window 2&img=https://ntvb.tmsimg.com/assets/p24155172_v_h8_ab.jpg&duration=6702&subcode=en&substitleurl=substitles/Movies/Through.My.Window/Through.My.Window.Across.The.Sea.English-WWW.MY-SUBS.CO.srt",
});
mapRedirect(["through-my-window-looking-at-you", "1139566"], {
    splashimgurl: "https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABa-GSEWFAx6NC3tG3K4whb97lo3T30B4qvEfcLwBKfxdnPw9sV2ZA5jDiiyk-VDJzpR1lPegVWBkE4qXPkgpPl02YSKDww5wm4tK.jpg",
    title: "Watch Through My Window: Looking At You",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/d5e97d3a51e721cf9e8f99ccfc51b7ece83412d0f6c536532cf99bf6f2067b78f9b433d4fcae9c0854ad74bbbb7d93bc3b5fde0ec777452a06a839c78ab42cb478b08b9f197886c81b39118c3b8e949cf8a56885c1623e60c35b01648d1095d9bff4093f363a11a3bbec30e7ac4843bf865fd867bf7b51bf9a0595be9ba6c1235367ff800fb80c34c660684d0e2d9a09/playlist.m3u8&title-1=Through My Window 3&img=https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABa-GSEWFAx6NC3tG3K4whb97lo3T30B4qvEfcLwBKfxdnPw9sV2ZA5jDiiyk-VDJzpR1lPegVWBkE4qXPkgpPl02YSKDww5wm4tK.jpg&duration=6311&subcode=en&substitleurl=substitles/Movies/Through.My.Window/Through.My.Window.3.Looking.at.You.srt",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/d5e97d3a51e721cf9e8f99ccfc51b7ece83412d0f6c536532cf99bf6f2067b78f9b433d4fcae9c0854ad74bbbb7d93bc3b5fde0ec777452a06a839c78ab42cb478b08b9f197886c81b39118c3b8e949cf8a56885c1623e60c35b01648d1095d9bff4093f363a11a3bbec30e7ac4843bf865fd867bf7b51bf9a0595be9ba6c1235367ff800fb80c34c660684d0e2d9a09/playlist.m3u8&title-1=Through My Window 3&img=https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABa-GSEWFAx6NC3tG3K4whb97lo3T30B4qvEfcLwBKfxdnPw9sV2ZA5jDiiyk-VDJzpR1lPegVWBkE4qXPkgpPl02YSKDww5wm4tK.jpg&duration=6311&subcode=en&substitleurl=substitles/Movies/Through.My.Window/Through.My.Window.3.Looking.at.You.srt",
});
mapRedirect(["past-lives", "666277"], {
    splashimgurl: "https://regionalculturalcentre.com/wp-content/uploads/elementor/thumbs/Past-Lives-Quad-Poster-scaled-qbym0kklpuu2mtrmhjdwiy8m8zp40xf98zsyb9ic16.jpg",
    title: "Watch Past Lives",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/45f5060398944ad0f6877adff29bd610de85a820a58d2610c756610aa00081388f58e039b7a45bf7e131aaf52d5bcb80cbdb6350d049399fac04178953fdd61c5fa73974fb8242d639d137519ba59c8b54052880467c9800e3d5aa2df8638c40021652d32797c06ee087464a3fad3edb4ca4534d9556044fa99dd85320affa3e8cd88d35bd3bb1cf5023436195eb5818/playlist.m3u8&title-1=Past Lives&img=https://regionalculturalcentre.com/wp-content/uploads/elementor/thumbs/Past-Lives-Quad-Poster-scaled-qbym0kklpuu2mtrmhjdwiy8m8zp40xf98zsyb9ic16.jpg&duration=6343&subcode=en&substitleurl=substitles\Past-Lives-2023.srt",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/45f5060398944ad0f6877adff29bd610de85a820a58d2610c756610aa00081388f58e039b7a45bf7e131aaf52d5bcb80cbdb6350d049399fac04178953fdd61c5fa73974fb8242d639d137519ba59c8b54052880467c9800e3d5aa2df8638c40021652d32797c06ee087464a3fad3edb4ca4534d9556044fa99dd85320affa3e8cd88d35bd3bb1cf5023436195eb5818/playlist.m3u8&title-1=Past Lives&img=https://regionalculturalcentre.com/wp-content/uploads/elementor/thumbs/Past-Lives-Quad-Poster-scaled-qbym0kklpuu2mtrmhjdwiy8m8zp40xf98zsyb9ic16.jpg&duration=6343&subcode=en&substitleurl=substitles\Past-Lives-2023.srt",
});
mapRedirect(["warning", "898981"], {
    splashimgurl: "https://assets-in.bmscdn.com/discovery-catalog/events/et00315047-zdccaumgvf-landscape.jpg",
    title: "Watch Warning (Punjabi Movie)",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8ocgd3",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8ocgd3",
});
mapRedirect(["warning-2", "1237618"], {
    splashimgurl: "https://i.ytimg.com/vi/peks7KCLkmc/maxresdefault.jpg",
    title: "Watch Warning 2 (Punjabi Movie)",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/2fe08d897a2b45a94efd2bfbf765dfa0ce526581eb2df213e017dfbc76a674f78caf8daa677753e4d91cc7f23247742624688aaca5cea5f087be9fea3bbff7d6926db3a5217a88029c83f721ef87ec134a4de2fa23cdb0df9a2cfce2aa4a226b082cc5c12c370a1dcc5c60c6e5c5ce50c4197da3f8d45dd262c355f069396e5d/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Warning%202&img=https://img.sflix.to/xxrz/1200x600/224/2a/d5/2ad5833b688ec7966bc30c5fcfa91e5a/2ad5833b688ec7966bc30c5fcfa91e5a.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/2fe08d897a2b45a94efd2bfbf765dfa0ce526581eb2df213e017dfbc76a674f78caf8daa677753e4d91cc7f23247742624688aaca5cea5f087be9fea3bbff7d6926db3a5217a88029c83f721ef87ec134a4de2fa23cdb0df9a2cfce2aa4a226b082cc5c12c370a1dcc5c60c6e5c5ce50c4197da3f8d45dd262c355f069396e5d/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Warning%202&img=https://img.sflix.to/xxrz/1200x600/224/2a/d5/2ad5833b688ec7966bc30c5fcfa91e5a/2ad5833b688ec7966bc30c5fcfa91e5a.jpg",
});
mapRedirect(["teri-baaton-mein-aisa-uljha-jiya", "1110390"], {
    splashimgurl: "https://assets-in.bmscdn.com/discovery-catalog/events/et00383266-rtaggvtrje-landscape.jpg",
    title: "Watch Teri Baaton Mein Aisa Uljha Jiya",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/3c82efba465dd2d5e167903ac4fdb3b648a01869b42561c707069f5f15fb506514e91db502b41a01d4a297b8d9a78418a1653aa7f4c22e13a1e0dedf497176bed3351f49a35aa2ae3d4bbcf1461881cf6a8c3995fb429981426f7289442ec4e9ccb428e77daf2c0b0a05833d7531ec6cfbaaf291b2a9f23e2bf006e2e12fdaac/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Teri%20Baaton%20Mien%20Aisa%20Uljha%20Jia&img=https://img.sflix.to/xxrz/1200x600/224/a6/84/a6842917e73642b7bfec7ecaed55382f/a6842917e73642b7bfec7ecaed55382f.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/3c82efba465dd2d5e167903ac4fdb3b648a01869b42561c707069f5f15fb506514e91db502b41a01d4a297b8d9a78418a1653aa7f4c22e13a1e0dedf497176bed3351f49a35aa2ae3d4bbcf1461881cf6a8c3995fb429981426f7289442ec4e9ccb428e77daf2c0b0a05833d7531ec6cfbaaf291b2a9f23e2bf006e2e12fdaac/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Teri%20Baaton%20Mien%20Aisa%20Uljha%20Jia&img=https://img.sflix.to/xxrz/1200x600/224/a6/84/a6842917e73642b7bfec7ecaed55382f/a6842917e73642b7bfec7ecaed55382f.jpg",
});
mapRedirect(["farha-urdu", "856437"], {
    splashimgurl: "https://miro.medium.com/v2/resize:fit:1024/1*P9-yXMpuwtTu5wMJ8hwdaQ.jpeg",
    title: "Watch Farha With Urdu Subtitle",
    video: "series.html?source=https://116vod-adaptive.akamaized.net/exp=1713703945~acl=%2Fdfe5a0ac-78f0-4482-b0ad-8392a42a23ab%2F%2A~hmac=e6c0f451d34d7909c487bae03628188446d3754bfa3845f8ba34617d0ed7ebba/dfe5a0ac-78f0-4482-b0ad-8392a42a23ab/sep/video/05af4d09,25a4049a,55dd4a1c,cd148436,e386b906/audio/689c0164/master.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Watch%20Farha&img=https://destinationksa.com/wp-content/uploads/2022/12/6-6.png",
    video2: "series2.html?source=https://116vod-adaptive.akamaized.net/exp=1713703945~acl=%2Fdfe5a0ac-78f0-4482-b0ad-8392a42a23ab%2F%2A~hmac=e6c0f451d34d7909c487bae03628188446d3754bfa3845f8ba34617d0ed7ebba/dfe5a0ac-78f0-4482-b0ad-8392a42a23ab/sep/video/05af4d09,25a4049a,55dd4a1c,cd148436,e386b906/audio/689c0164/master.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Watch%20Farha&img=https://destinationksa.com/wp-content/uploads/2022/12/6-6.png",
});
mapRedirect(["suveyda-urdu", "1010849"], {
    splashimgurl: "https://vhx.imgix.net/alchemiya2/assets/57b2f19b-be2d-4334-bb7c-19125af93ee6-e32a4370.jpg?auto=format%2Ccompress&fit=crop&h=720&q=75&w=1280",
    title: "Watch Suveyda With Urdu Subtitle",
    video: "series.html?source=https://www.aparat.com/video/hls/manifest/visittype/embed/videohash/pvwu8/f/pvwu8.m3u8?k=ec0d2&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Suveyda%20Urdu&img=https://static.daktilo.com/sites/685/uploads/2022/05/16/large/suveyda-afis-kopyala-1652699052.jpg",
    video2: "series2.html?source=https://www.aparat.com/video/hls/manifest/visittype/embed/videohash/pvwu8/f/pvwu8.m3u8?k=ec0d2&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Suveyda%20Urdu&img=https://static.daktilo.com/sites/685/uploads/2022/05/16/large/suveyda-afis-kopyala-1652699052.jpg",
});
mapRedirect(["turkler-geliyor-urdu", "665766"], {
    splashimgurl: "https://m.media-amazon.com/images/S/pv-target-images/a951f324c05366a4cb7621d080d961ed0b9edfc82271f05cd2d2b9030a0303c6.jpg",
    title: "Watch Turkler Geliyor With Urdu Subtitle",
    video: "series.html?source=https://www.aparat.com/video/hls/manifest/visittype/embed/videohash/H1tCF/f/H1tCF.m3u8?k=86cb8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Turkler%20Geliyor&img=https://i.ytimg.com/vi/gnSxOla5mvI/mqdefault.jpg",
    video2: "series2.html?source=https://www.aparat.com/video/hls/manifest/visittype/embed/videohash/H1tCF/f/H1tCF.m3u8?k=86cb8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Turkler%20Geliyor&img=https://i.ytimg.com/vi/gnSxOla5mvI/mqdefault.jpg",
});
mapRedirect(["can-feda-urdu", "517388"], {
    splashimgurl: "https://image.tmdb.org/t/p/w780/b8fOz2uAjBWDIRaGsyDzND0DDMW.jpg",
    title: "Watch Can Feda (To Die For) With Urdu Subtitle",
    video: "https://ok.ru/videoembed/2010887686900",
    video2: "https://ok.ru/videoembed/2010887686900",
});
mapRedirect(["malazgirt-1071-urdu", "699395"], {
    splashimgurl: "https://static.next-episode.net/tv-shows-images/huge/malazgirt-1071.jpg",
    title: "Watch Malazgirt 1071 With Urdu Subtitle",
    video: "series.html?source=https://www.aparat.com/video/hls/manifest/visittype/embed/videohash/vhWqm/f/vhWqm.m3u8?k=ca64f&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Malazgirt%201071&img=https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQD_1LFKrUS3G0mWQHbFZwqW9zrZKajteQ3ISGrhu01InGAKbJaUSTFz4jbjdtBsuCEEp8&usqp=CAU",
    video2: "series2.html?source=https://www.aparat.com/video/hls/manifest/visittype/embed/videohash/vhWqm/f/vhWqm.m3u8?k=ca64f&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Malazgirt%201071&img=https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQD_1LFKrUS3G0mWQHbFZwqW9zrZKajteQ3ISGrhu01InGAKbJaUSTFz4jbjdtBsuCEEp8&usqp=CAU",
});
mapRedirect(["ghazi-iskender-urdu", "875700", "875698"], {
    splashimgurl: "https://i.ytimg.com/vi/awDY8ASIn9k/maxresdefault.jpg",
    title: "Watch Ghazi Iskender With Urdu Subtitle",
    video: "series.html?source=https://www.aparat.com/video/hls/manifest/visittype/embed/videohash/NgtYk/f/NgtYk.m3u8?k=3b976&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Ghazi%20Iskender&img=https://ts2.mm.bing.net/th?q=tozkoparan+iskender+zafer+full+izle",
    video2: "series2.html?source=https://www.aparat.com/video/hls/manifest/visittype/embed/videohash/NgtYk/f/NgtYk.m3u8?k=3b976&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Ghazi%20Iskender&img=https://ts2.mm.bing.net/th?q=tozkoparan+iskender+zafer+full+izle",
});
mapRedirect(["kgf-chapter-1", "564147"], {
    splashimgurl: "https://assets-in.bmscdn.com/discovery-catalog/events/et00042769-lnyzzrlgrq-landscape.jpg",
    title: "Watch K.G.F: Chapter 1",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/ae44a7f6e6dd0f98311c2e69bf015c0344e11b56b501a0d6aca8060ee41980fd4336da3cde4181f410f7daee9d584a8770e5263d22ff4634900a752cae9c79d76076f61efe6ccebed763c1eca43ae4206b3e4abac35d2e98d54b1107c5570f20c6c10b8a3f293320c1123262f5b6eaf1279f84689e8c91ff5608febfdafd9c5edcddc62fd0c7708acbbd3109e7a53805/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=K.G.F:%20Ch%201&img=https://assets.mubicdn.net/images/film/221349/image-w1280.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/ae44a7f6e6dd0f98311c2e69bf015c0344e11b56b501a0d6aca8060ee41980fd4336da3cde4181f410f7daee9d584a8770e5263d22ff4634900a752cae9c79d76076f61efe6ccebed763c1eca43ae4206b3e4abac35d2e98d54b1107c5570f20c6c10b8a3f293320c1123262f5b6eaf1279f84689e8c91ff5608febfdafd9c5edcddc62fd0c7708acbbd3109e7a53805/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=K.G.F:%20Ch%201&img=https://assets.mubicdn.net/images/film/221349/image-w1280.jpg",
});
mapRedirect(["kgf-chapter-2", "587412"], {
    splashimgurl: "https://cinemabolthey.com/wp-content/uploads/2023/07/567708143997813.6284a8db8a7b2.png",
    title: "Watch K.G.F: Chapter 2",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/8960091c1b83fd157331dd749e778624304f9143c582ed6b9d548ec923b1f8eb267c30284fb0d6a17ced56fff3b737f34d23937531433ad634ed7d1cab44729726558b7237e9bdf26be3ac94836b1425d26d0e739fcdb1f7c9f4bd6ea5d2cb62e707afa46e53bdebaa1473de4301d007612669732292f22da39b406559e9da2f9dcf7229b631b8b246f289caf669b62d/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=K.G.F:%20Ch%202&img=https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2022/06/cancer-1-1654621660.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/8960091c1b83fd157331dd749e778624304f9143c582ed6b9d548ec923b1f8eb267c30284fb0d6a17ced56fff3b737f34d23937531433ad634ed7d1cab44729726558b7237e9bdf26be3ac94836b1425d26d0e739fcdb1f7c9f4bd6ea5d2cb62e707afa46e53bdebaa1473de4301d007612669732292f22da39b406559e9da2f9dcf7229b631b8b246f289caf669b62d/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=K.G.F:%20Ch%202&img=https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2022/06/cancer-1-1654621660.jpg",
});
mapRedirect(["kingdom-of-heaven-hindi", "1495"], {
    splashimgurl: "https://prod-ripcut-delivery.disney-plus.net/v1/variant/disney/9EF5C499721EEC2D5715D74ED54C9976D183F5BDDEC01D0CC543B4056C2937ED/scale?width=1200&amp;aspectRatio=1.78&amp;format=webp",
    title: "Watch Kingdom of heaven hindi dubbed",
    video: "https://streamtape.com/e/eALWVX1glyUYbPA",
    video2: "https://streamtape.com/e/eALWVX1glyUYbPA",
    download: "https://streamtape.com/v/eALWVX1glyUYbPA",
    enableDownload: true,
});
mapRedirect(["salaar-part-1", "1220594", "770906-1"], {
    splashimgurl: "https://imgeng.jagran.com/images/2023/dec/SALAAR%20release%20date1702739527694.jpg",
    title: "Watch Salaar: Part 1 - Ceasefire ",
    video: "https://okmalayalam.org/bewab/8.php?url=https://teamomw6.com/hls/xwwm2lnipegqkov2bs4uaigpuetyfqdlusb3oqddc,v3dnv4rwjyzk5u6kprq,53dnv4rwjy6kdbf2f7q,f3dnv4rwjyqjl63a4ba,.urlset/master.m3u8",
    video2: "https://okmalayalam.org/bewab/8.php?url=https://teamomw6.com/hls/xwwm2lnipegqkov2bs4uaigpuetyfqdlusb3oqddc,v3dnv4rwjyzk5u6kprq,53dnv4rwjy6kdbf2f7q,f3dnv4rwjyqjl63a4ba,.urlset/master.m3u8",
});
mapRedirect(["the-kings-man", "476669"], {
    splashimgurl: "https://prod-ripcut-delivery.disney-plus.net/v1/variant/disney/20C74CBEC59D3260075DED510E27341B4BCCE9B06C28BEC24D56C83B9158AF7C/scale?width=1200&aspectRatio=1.78&format=webp",
    title: "Watch The King's Man",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/2c54fee8575bd3446d9f96cbb807b1fccc028f593a57cac00e4381fefb77fb23c5ef650be066c90f8eafee5d4a34e9899cbbadbd01e17d6af32eb8940e99df268811e865b58c6472a68337369a2b6bcbb397b51e3e5c1f0cfad2f40c074062736ce56b494570e732815309f855f1d98c21ad72c4cd30380490b064af1fac3f532a5a6fc66d6e2e271c25f403bdef159d/playlist.m3u8&subcode=en&substitleurl=substitles/movies/the-kings-man-en.srt&title-1=The%20King's%20Man&img=https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p15990473_v_h9_ai.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/2c54fee8575bd3446d9f96cbb807b1fccc028f593a57cac00e4381fefb77fb23c5ef650be066c90f8eafee5d4a34e9899cbbadbd01e17d6af32eb8940e99df268811e865b58c6472a68337369a2b6bcbb397b51e3e5c1f0cfad2f40c074062736ce56b494570e732815309f855f1d98c21ad72c4cd30380490b064af1fac3f532a5a6fc66d6e2e271c25f403bdef159d/playlist.m3u8&subcode=en&substitleurl=substitles/movies/the-kings-man-en.srt&title-1=The%20King's%20Man&img=https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p15990473_v_h9_ai.jpg",
});
mapRedirect(["dune-part-1", "438631"], {
    splashimgurl: "https://rth24blog.files.wordpress.com/2022/03/dune-movie-official-poster-banner-feature.jpg?w=1024",
    title: "Watch Dune Part 1",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/70b47cea81c017cf2c80555753b7b5cc99aced4e29bcf241ccbc73e196af959b7fa7e4f70594c5fa339db051bdd10092f2b51c7da62ad8a3081bd60fa9b3fb8101bd31f3bcc002225b7d145ce7ed6751e960bf613007e20b5888024d872ad5574f274252193eeaf6a18584390bedf31911b8078e992974355dd100f7769ec19342d8b01bb76f635b044ba91fd8a8b83a/playlist.m3u8&subcode=en&substitleurl=substitles/movies/dune-part-1-en.srt&title-1=Dune%20Part%201&img=https://nbcpalmsprings.com/wp-content/uploads/sites/8/2021/10/DUNE-MOVIE-REVIEW-2021.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/70b47cea81c017cf2c80555753b7b5cc99aced4e29bcf241ccbc73e196af959b7fa7e4f70594c5fa339db051bdd10092f2b51c7da62ad8a3081bd60fa9b3fb8101bd31f3bcc002225b7d145ce7ed6751e960bf613007e20b5888024d872ad5574f274252193eeaf6a18584390bedf31911b8078e992974355dd100f7769ec19342d8b01bb76f635b044ba91fd8a8b83a/playlist.m3u8&subcode=en&substitleurl=substitles/movies/dune-part-1-en.srt&title-1=Dune%20Part%201&img=https://nbcpalmsprings.com/wp-content/uploads/sites/8/2021/10/DUNE-MOVIE-REVIEW-2021.jpg",
});
mapRedirect(["dune-part-2", "693134"], {
    splashimgurl: "https://media.cinemacloud.co.uk/imageFilm/1725_1_2.jpg",
    title: "Watch Dune Part 2",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/3aaa88c38b31509f91b4907a7d8ebf46f4e343f0c3c599a64f153bb71fa4c16c0f97c051daef7c5e064bbce8b1514ee8b0e163828cfdc764d4502bda072a4c43ff068a067208d785d9e8d4cc268c6c8c3107a3c7a9ab88b52515e5493731177aa6ad10c80108dc685994940aa81607e7f78a4706b09e1e3410d84fc24df213ce/playlist.m3u8&subcode=en&substitleurl=substitles/movies/dune-part-2-en.srt&title-1=Dune%20Part%202&img=https://img.vgn.at/a3bf54b5b7ca5325ff0965e9e914a1552a402dc6/2560x_75.webp",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/3aaa88c38b31509f91b4907a7d8ebf46f4e343f0c3c599a64f153bb71fa4c16c0f97c051daef7c5e064bbce8b1514ee8b0e163828cfdc764d4502bda072a4c43ff068a067208d785d9e8d4cc268c6c8c3107a3c7a9ab88b52515e5493731177aa6ad10c80108dc685994940aa81607e7f78a4706b09e1e3410d84fc24df213ce/playlist.m3u8&subcode=en&substitleurl=substitles/movies/dune-part-2-en.srt&title-1=Dune%20Part%202&img=https://img.vgn.at/a3bf54b5b7ca5325ff0965e9e914a1552a402dc6/2560x_75.webp",
});
mapRedirect(["shaitaan", "1187619"], {
    splashimgurl: "https://www.bollywoodhungama.com/wp-content/uploads/2023/05/Shaitaan-banner.jpg",
    title: "Watch Shaitaan Movie 2024 HD",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/e40a047efaa3c3a1cab940f7ada35cb1a303c0aa09676d18629cb68b9489d271d21fff38f04225215198c1919959934c10c08671754ee30468bbb487b2fc726ed40d38621fa460fb8fb264a9ea16b9d2fb35b241d6d8e1f6dfbbfd0622cbe241cd00426ef40caad0924a5290024e6cf874acf7d25fe221bf83608c74b284ed55/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Shaitaan&img=https://assets-in.bmscdn.com/discovery-catalog/events/et00384234-xqtmalpvfx-landscape.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/e40a047efaa3c3a1cab940f7ada35cb1a303c0aa09676d18629cb68b9489d271d21fff38f04225215198c1919959934c10c08671754ee30468bbb487b2fc726ed40d38621fa460fb8fb264a9ea16b9d2fb35b241d6d8e1f6dfbbfd0622cbe241cd00426ef40caad0924a5290024e6cf874acf7d25fe221bf83608c74b284ed55/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Shaitaan&img=https://assets-in.bmscdn.com/discovery-catalog/events/et00384234-xqtmalpvfx-landscape.jpg",
});
mapRedirect(["animal", "781732"], {
    splashimgurl: "https://www.koimoi.com/wp-content/new-galleries/2024/01/animal-box-office-ranbir-kapoor-led-action-thriller-enjoys-returns-of-almost-350-crores-after-32-days-001.jpg",
    title: "Watch Animal Full Movie",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/bf401b40369f957a567be4140c5208158545062ecdfbb850252a5ff3de8eb68474f89ffc4746c66707319f8fff9bfd32bce4426322d5d1414cab3c8a8f0080df3ff1105763a1e9087399ce29f9a3a91c9b67f99c7c73954d6ac1b267fcc5d8bfbe0585d164a357ed21fda2784c1490960b89fbb8ed6e22d958db7df60097c9995c2ea4c5903efe9bc87075f10fe2bc48/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Animal&img=https://content.tupaki.com/en/feeds/2023/12/01/212181-animal.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/bf401b40369f957a567be4140c5208158545062ecdfbb850252a5ff3de8eb68474f89ffc4746c66707319f8fff9bfd32bce4426322d5d1414cab3c8a8f0080df3ff1105763a1e9087399ce29f9a3a91c9b67f99c7c73954d6ac1b267fcc5d8bfbe0585d164a357ed21fda2784c1490960b89fbb8ed6e22d958db7df60097c9995c2ea4c5903efe9bc87075f10fe2bc48/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Animal&img=https://content.tupaki.com/en/feeds/2023/12/01/212181-animal.jpg",
});
mapRedirect(["the-idea-of-you", "843527"], {
    splashimgurl: "https://images.radio.com/aiu-media/IDEA2024PRShowBannerGreen1920x1080EVRGRNPVFINALenUSCPS-9e13ced5-4996-42a5-86ba-7b362a1d972b.jpg",
    title: "Watch The Idea Of You",
    video: "https://w1.nites.is/?trembed=0&trid=4956&trtype=1",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/22dbdaa9e916aacb911676e47d375cf532f851f62fa4e94f6f29de59c2108d1610f7029b0da1ed902dcce4cb45bd8fdf6ea95ddeb96b0cbefb12b9c11a295de3fa3114130fa09d814b6a6a7446dbf2be27873a2aaba1755d79ead92eb0d4fc710c0b5a2881a2c292880ca69de88886646c50ff3f9bbeb7f975ab1bc0b5e90497/playlist.m3u8&subcode=en&substitleurl=substitles/movies/the-idea-of-you-eng.srt&title-1=The Idea Of You&img=https://imageio.forbes.com/specials-images/imageserve/6633b68e1cb4fcc8fa4be61f/-Idea-of-You--streaming-on-Amazon-Prime-Video-/0x0.jpg?format=jpg&crop=2250,1500,x592,y0,safe&width=960",
});
mapRedirect(["pathaan", "864692"], {
    splashimgurl: "https://www.bollywoodhungama.com/wp-content/uploads/2020/08/Pathaan-cover-news.jpg",
    title: "Watch Pathaan",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/4f719139e3ea7c2a82d36511460b5ca20f9c3a58e28a0d3a9f5bad4c3a2df26b63ee9e82892466815e0919a3e2a58cbd2d0a6909e886532dba157d96899e42ee152efa45c0564c9bc4ee8a910291e31ed6c63285a6c08193f55aa227ee5f08e7de2751d1a6615ed77b01f6d94bafc0e611adebb2aab267e19e1aa9209b28733c1ba43ebdc5d7a00ac927e166e1082df5/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Pathaan&img=https://miro.medium.com/v2/resize:fit:1400/0*ym2r5EzPjhX2Mft7.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/4f719139e3ea7c2a82d36511460b5ca20f9c3a58e28a0d3a9f5bad4c3a2df26b63ee9e82892466815e0919a3e2a58cbd2d0a6909e886532dba157d96899e42ee152efa45c0564c9bc4ee8a910291e31ed6c63285a6c08193f55aa227ee5f08e7de2751d1a6615ed77b01f6d94bafc0e611adebb2aab267e19e1aa9209b28733c1ba43ebdc5d7a00ac927e166e1082df5/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Pathaan&img=https://miro.medium.com/v2/resize:fit:1400/0*ym2r5EzPjhX2Mft7.jpg",
});
mapRedirect(["jailer"], {
    splashimgurl: "https://theleaflet.in/wp-content/uploads/2023/10/Jailer-Movie-scaled.jpg",
    title: "Watch Jailer",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/6e286ac8e0a3e1b0bc9dc26f779a9f8a045682353c113f5153a572e70299acbf43f15e7afaad27343cc69751ecc33843919267fbafce59342ffaa96b724090250a32e11e901bbe14e38d9f33238b1eaab2b53dd981ce48a34b66fe5d216c11cd9f1533860fea59c2f054283edce2a1ac49444b02cd9bdfdd9c92f338f5e1804dfa953441ef04fa1ee4e56084817141b3/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Jailer&img=https://www.hindustantimes.com/ht-img/img/2023/09/04/1600x900/Jailer_1693801825950_1693801854455.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/6e286ac8e0a3e1b0bc9dc26f779a9f8a045682353c113f5153a572e70299acbf43f15e7afaad27343cc69751ecc33843919267fbafce59342ffaa96b724090250a32e11e901bbe14e38d9f33238b1eaab2b53dd981ce48a34b66fe5d216c11cd9f1533860fea59c2f054283edce2a1ac49444b02cd9bdfdd9c92f338f5e1804dfa953441ef04fa1ee4e56084817141b3/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Jailer&img=https://www.hindustantimes.com/ht-img/img/2023/09/04/1600x900/Jailer_1693801825950_1693801854455.jpg",
});
mapRedirect(["fighter", "784651"], {
    splashimgurl: "https://imageio.forbes.com/specials-images/imageserve/65bf738d76ae76563adf151c/Indian-stars-Deepika-Padukone-and-Hrithik-Roshan-on-a-poster-of-the-Hindi-film/0x0.jpg?format=jpg&crop=1502,844,x183,y33,safe&width=960",
    title: "Watch Fighter",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/bed96f44855083476fac8bb632c60a053c7836ce4716153a646fcd9fa891b69e6f06d32cf3f7137070e958f8fcbfb13464815019eb2bea728f6c889e7133ae672b6a51efb4142a4a5d37e974b9c05eda9fbde75fb2e25fcf09265d45044fcd16636b33570b3b05c08787014cb8bd03bccd14418c8f109d9d3131f7d439b275f6/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Fighter&img=https://static-koimoi.akamaized.net/wp-content/new-galleries/2024/01/fighter-movie-review-01.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/bed96f44855083476fac8bb632c60a053c7836ce4716153a646fcd9fa891b69e6f06d32cf3f7137070e958f8fcbfb13464815019eb2bea728f6c889e7133ae672b6a51efb4142a4a5d37e974b9c05eda9fbde75fb2e25fcf09265d45044fcd16636b33570b3b05c08787014cb8bd03bccd14418c8f109d9d3131f7d439b275f6/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Fighter&img=https://static-koimoi.akamaized.net/wp-content/new-galleries/2024/01/fighter-movie-review-01.jpg",
});
mapRedirect(["oye-bhole-oye", "1246507"], {
    splashimgurl: "https://about.chaupal.tv/wp-content/uploads/2024/05/oye-bhole-bhole-watch-now-jagjeet-sandhu.webp",
    title: "Watch Oye Bhole Oye (Punjabi Movie)",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/8ba3a2252298491d7bf30b957bc57006736e4fec53007de4ba4685011912a1e0ed7b18a5c4981abaee9e2d9694d11020a9a6a8b5eefb2959093aa36752f9864e218ada10e28f543615dc2b6df6c40656494e22ee08674b529ef2c7af534758d3fd07a4cc29b0e90932efda3f6d1455b25ac4543e964dd93e03b8cb6d1341eb0e/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Oye%20Bhole%20Oye&img=https://assets-in.bmscdn.com/discovery-catalog/events/et00384120-sdyvppmpvp-landscape.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/8ba3a2252298491d7bf30b957bc57006736e4fec53007de4ba4685011912a1e0ed7b18a5c4981abaee9e2d9694d11020a9a6a8b5eefb2959093aa36752f9864e218ada10e28f543615dc2b6df6c40656494e22ee08674b529ef2c7af534758d3fd07a4cc29b0e90932efda3f6d1455b25ac4543e964dd93e03b8cb6d1341eb0e/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Oye%20Bhole%20Oye&img=https://assets-in.bmscdn.com/discovery-catalog/events/et00384120-sdyvppmpvp-landscape.jpg",
});
mapRedirect(["tiger-3", "720557"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/gwtwjhikFumL8Xf8l6HwTQ1SjMt.jpg",
    title: "Watch Tiger 3 Movie",
    video: "https://vidsrc.xyz/embed/movie?tmdb=720557",
    video2: "series2.html?source=https://tmstr3.vidsrc.stream/stream/H4sIAAAAAAAAAwXB3XaCIAAA4FcCUZe7W6fIKPGIgAfu5KeVgrOtrfTp930AFm8eXpzpkc2924DCb5y5ZInt89zn6F1MlFWlfjYd.W47u5wQ2ZrxCc0UUAO.0lawYPi4nNdtZqO7My6Z6xxow5y1uyuvluKnGXBv9mQrQ0iNvNYazrhBAlkuuUtcWu_kSid60wFXVWTcH653m8y1EoT22A26pETss6MZH4LFz5c9SN1NOvJ4TAWWfyYhqxJpZrEuXckWBl4niz9gzRk0Ui1.UK8ewMzEx84e5lstFfIScwVcelppUBLTftCrQuRYxeK3GjER7eNc76X4B_EMhzMhAQAA/master.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Tiger 3&img=https://image.tmdb.org/t/p/original/vtAgxwBd8a1AYeQpbXOPYzdORU9.jpg",
});
mapRedirect(["blackia-1", "605971"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bCSmdEejbEWKzOGP4UDeCkKa52I.jpg",
    title: "Watch Blackia 1",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/892a3898adeeba7ac9bba9dbf76dc5dbfc28e6e7e0afde5cd6a7f515920c9a37c3c16ac7e41f6c830ec18983146ce320f598700bce64aefa524e61622ebaec1e28ab4a0102d8df79973a374450cad6576d1bf93bba4037c4ee09e3f88bcac49191416bfa6616244b74ff64b27121b7c151444f0cc430075b2f428ba21722d28e/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Blackia%201&img=https://media.themoviedb.org/t/p/original/bCSmdEejbEWKzOGP4UDeCkKa52I.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/892a3898adeeba7ac9bba9dbf76dc5dbfc28e6e7e0afde5cd6a7f515920c9a37c3c16ac7e41f6c830ec18983146ce320f598700bce64aefa524e61622ebaec1e28ab4a0102d8df79973a374450cad6576d1bf93bba4037c4ee09e3f88bcac49191416bfa6616244b74ff64b27121b7c151444f0cc430075b2f428ba21722d28e/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Blackia%201&img=https://media.themoviedb.org/t/p/original/bCSmdEejbEWKzOGP4UDeCkKa52I.jpg",
});
mapRedirect(["blackia-2", "1253059"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/4xSwUdwDw43YV8eVXFF7FquN2vH.jpg",
    title: "Watch Blackia 2",
    video: "https://okmalayalam.org/bewab/8.php?url=https://teamomw6.com/hls/xwwm2z4tpegqkov2bs4eapm6ucr6hjfn55oqkj5fp,3fg4zfexwsvqsxna3tq,tfg4zfexwsqvqlnjewq,.urlset/master.m3u8",
    video: "https://okmalayalam.org/bewab/8.php?url=https://teamomw6.com/hls/xwwm2z4tpegqkov2bs4eapm6ucr6hjfn55oqkj5fp,3fg4zfexwsvqsxna3tq,tfg4zfexwsqvqlnjewq,.urlset/master.m3u8",
});
mapRedirect(["kingdom-of-the-planet-of-the-apes", "653346"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/iHYh4cdO8ylA3W0dUxTDVdyJ5G9.jpg",
    title: "Watch Kingdom of the Planet of the Apes",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/eb653fef7e523c20b2ac3809db802acb7d7283afad96523d768378bcc0fbfa8598fbabbc42f192d7bd80c3b6a1d083472a4141f8582133db77b9e9bfce65bd994d7d9af9dc0af7c924f21103137a88497732a73da633fc1fe496d384ff18b61a900088dbed6fc724fe355f5e764530012ab18da81cf4a9491bfe28d5aa3e0763/playlist.m3u8&subcode=en&substitleurl=subtitles/movies/kingdom-of-the-planet-of-the-apes-eng.srt&title-1=Kingdom%20of%20the%20Planet%20of%20the%20Apes&img=https://image.tmdb.org/t/p/original/wMPb9uQjeE6CJ2fJQlYzyhvA1HN.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/eb653fef7e523c20b2ac3809db802acb7d7283afad96523d768378bcc0fbfa8598fbabbc42f192d7bd80c3b6a1d083472a4141f8582133db77b9e9bfce65bd994d7d9af9dc0af7c924f21103137a88497732a73da633fc1fe496d384ff18b61a900088dbed6fc724fe355f5e764530012ab18da81cf4a9491bfe28d5aa3e0763/playlist.m3u8&subcode=en&substitleurl=subtitles/movies/kingdom-of-the-planet-of-the-apes-eng.srt&title-1=Kingdom%20of%20the%20Planet%20of%20the%20Apes&img=https://image.tmdb.org/t/p/original/wMPb9uQjeE6CJ2fJQlYzyhvA1HN.jpg",
});
mapRedirect(["boy-kills-world", "882059"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/2QhXMGOwnodXNaLaGbVQUHjIY5P.jpg",
    title: "Watch Boy Kills World",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/ca5809284f387d962b813e7d50f447b651cc317790fddc4d79cf1e956a2c6e9e81b04e3d9f79e92aad4a6839349fc786bb49ad17f8a3f95762b8b73c33397f2db02601f74a8718c24b3459ddf5340bda72e531c8ab730d524e1ea60c3ed4adb6416e290d274a3c8851b930408e9fd417e4899d9c9dc928e54104324436418bc5/playlist.m3u8&subcode=en&substitleurl=substitles/movies/boy-kills-world-eng.srt&title-1=Boy%20Kills%20World&img=https://media.themoviedb.org/t/p/original/1m1rXopfNDVL3UMiv6kriYaJ3yE.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/ca5809284f387d962b813e7d50f447b651cc317790fddc4d79cf1e956a2c6e9e81b04e3d9f79e92aad4a6839349fc786bb49ad17f8a3f95762b8b73c33397f2db02601f74a8718c24b3459ddf5340bda72e531c8ab730d524e1ea60c3ed4adb6416e290d274a3c8851b930408e9fd417e4899d9c9dc928e54104324436418bc5/playlist.m3u8&subcode=en&substitleurl=substitles/movies/boy-kills-world-eng.srt&title-1=Boy%20Kills%20World&img=https://media.themoviedb.org/t/p/original/1m1rXopfNDVL3UMiv6kriYaJ3yE.jpg",
});
mapRedirect(["challengers", "937287"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/idc5xkQVomXd9KZGo8q9Rd0fpt8.jpg",
    title: "Watch Challengers English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/c1a82a9e1ae4b3c8160c3f2a4cf5e82b1f15f277cde92fad5b5a5671db6ea3249f9b5e3b02777ed4b1a85273ed44537d9c11522874230d8ab5ec72290a3c0ea929ae02029aa755d3330f83cb39bbc7f2d0c64438a3831023ebcf43d7cb28a0051541a7c6e9fd7256dd63d6ebac534a4eeb57c861fb68c3b8fc53d118906c207b/playlist.m3u8&subcode=en&substitleurl=substitles/movies/challengers-eng.srt&title-1=Challengers&img=https://image.tmdb.org/t/p/original/rYPiGS7tTNNiOn2pyrh04MpipMV.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/c1a82a9e1ae4b3c8160c3f2a4cf5e82b1f15f277cde92fad5b5a5671db6ea3249f9b5e3b02777ed4b1a85273ed44537d9c11522874230d8ab5ec72290a3c0ea929ae02029aa755d3330f83cb39bbc7f2d0c64438a3831023ebcf43d7cb28a0051541a7c6e9fd7256dd63d6ebac534a4eeb57c861fb68c3b8fc53d118906c207b/playlist.m3u8&subcode=en&substitleurl=substitles/movies/challengers-eng.srt&title-1=Challengers&img=https://image.tmdb.org/t/p/original/rYPiGS7tTNNiOn2pyrh04MpipMV.jpg",
});
mapRedirect(["passengers-2016", "274870"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/xh2ffKVGuWgQD7lEKDMXAIaybLl.jpg",
    title: "Watch Passengers (2016) English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/2e8de1e6d034b23fb372ba051caee7114ae31a3f5a31b496ce5771fa28ea5cdab3dd9c32743d2e94f069e4371e94bb64b567df405f0f4bbe42830e0b3b10de0d2075e18dac3d229d53d6bd520e4d17418962ff339c4d6636f34990838903ba0ec470ccdbc5a4966effd11a1b0c5fac60e8fd759564001c18e43b6eb36a30375c5c5bf9fd0947322a73169622303bbe5e/playlist.m3u8&subcode=en&substitleurl=substitles/movies/passengers-2016-eng.srt&title-1=Passengers&img=https://image.tmdb.org/t/p/original/gHz4ZQytRs8YGrqFMwB3Vrr8pig.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/2e8de1e6d034b23fb372ba051caee7114ae31a3f5a31b496ce5771fa28ea5cdab3dd9c32743d2e94f069e4371e94bb64b567df405f0f4bbe42830e0b3b10de0d2075e18dac3d229d53d6bd520e4d17418962ff339c4d6636f34990838903ba0ec470ccdbc5a4966effd11a1b0c5fac60e8fd759564001c18e43b6eb36a30375c5c5bf9fd0947322a73169622303bbe5e/playlist.m3u8&subcode=en&substitleurl=substitles/movies/passengers-2016-eng.srt&title-1=Passengers&img=https://image.tmdb.org/t/p/original/gHz4ZQytRs8YGrqFMwB3Vrr8pig.jpg",
});
mapRedirect(["oppenheimer", "872585"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/sHTqJPdZUS9HF0QpfQb7Z0JAKv9.jpg",
    title: "Watch Oppenheimer English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/3b20a119e1467942ea649f4cfaeb0248428f955fb7c1323729516e99f617f6abad1372872f8093d05d8b8d76c24bf17e4e5a59fbc79ed4c0fce9b8f20213e4b2fadb5fbb256fb8127250e4317cc0b1a77a9a6d3bf265c514352765c20915435df2f459b22ea96fa7ed8b9f62e409655edf6b44d7dccf04e3f8468718dbb5b67a076d3ba3e393d72a961cf0874b65c653/playlist.m3u8&subcode=en&substitleurl=substitles/movies/oppenheimer-eng.srt&title-1=&img=https://image.tmdb.org/t/p/original/lybU7fxqmg2l0jqU8N4ZpsSmPQq.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/3b20a119e1467942ea649f4cfaeb0248428f955fb7c1323729516e99f617f6abad1372872f8093d05d8b8d76c24bf17e4e5a59fbc79ed4c0fce9b8f20213e4b2fadb5fbb256fb8127250e4317cc0b1a77a9a6d3bf265c514352765c20915435df2f459b22ea96fa7ed8b9f62e409655edf6b44d7dccf04e3f8468718dbb5b67a076d3ba3e393d72a961cf0874b65c653/playlist.m3u8&subcode=en&substitleurl=substitles/movies/oppenheimer-eng.srt&title-1=&img=https://image.tmdb.org/t/p/original/lybU7fxqmg2l0jqU8N4ZpsSmPQq.jpg",
});
mapRedirect(["laapataa-ladies", "1163194"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/1289XbegHS0NLeK5VE7R6inZyw7.jpg",
    title: "Watch Laapataa Ladies",
    video: "series.html?source=https://i-cdn-0.loner300artoa.com/stream2/i-cdn-0/c811f54666182054335475b10a6f3a14/MJTMsp1RshGTygnMNRUR2N2MSlnWXZEdMNDZzQWe5MDZzMmdZJTO1R2RWVHZDljekhkSsl1VwYnWtx2cihVT25ERZhnTqZlaa1WWwo1VJBjWE1UNaRlVplleZJTTExWbPRkVq9EVBpXTUVUP:1716963077:139.135.39.16:dbc7c683600a3c8317afb71d2741383328fea8ad4470dab8ee33cfcea71840fd/index.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Laapataa%20Ladies&img=https://media.themoviedb.org/t/p/original/uUVXEEyMsyWxrcbmAppUCYg6egV.jpg",
    video2: "series2.html?source=https://cdn4505.loner300artoa.com/stream2/i-cdn-0/c811f54666182054335475b10a6f3a14/MJTMsp1RshGTygnMNRUR2N2MSlnWXZEdMNDZzQWe5MDZzMmdZJTO1R2RWVHZDljekhkSsl1VwYnWtx2cihVT25ERZhnTqZlaa1WWwo1VJBjWE1UNaRlVplleZJTTExWbPRkVq9EVBpXTUVUP:1716913257:139.135.39.16:dbc7c683600a3c8317afb71d2741383328fea8ad4470dab8ee33cfcea71840fd/index.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Laapataa%20Ladies&img=https://media.themoviedb.org/t/p/original/uUVXEEyMsyWxrcbmAppUCYg6egV.jpg",
    download: "https://d27.doodrive.com/d/d98n9x?d=acb84a25f02267578eaad3cc",
    enableDownload: true,
});
mapRedirect(["premam-2019", "590012"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lo0qqae6fa4W69piIdMoHuVbDzO.jpg",
    title: "Watch Premam (Chitralahari) 2019",
    video: "series.html?source=https://i-arch-400.loner300artoa.com/stream2/i-arch-400/c811f54666182054335475b10a6f3a14/MJTMsp1RshGTygnMNRUR2N2MSlnWXZEdMNDZzQWe5MDZzMmdZJTO1R2RWVHZDljekhkSsl1VwYnWtx2cihVT2pVbWtWWq5EbNpGZr1ERNVzTEdGeZpXQ18EVklWWXlFNZdlUp5EVSlmT6NWP:1716918432:139.135.39.16:c8f8ea8d32eb9861fda9de6379c3bf47499e46a5fe2930ddad718fddfbaec81f/index.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Premam%20(Chitralahari)&img=https://image.tmdb.org/t/p/original/hqlyUXs5KqcmvpisRIUE3SyAxEX.jpg",
    video2: "series2.html?source=https://i-arch-400.loner300artoa.com/stream2/i-arch-400/c811f54666182054335475b10a6f3a14/MJTMsp1RshGTygnMNRUR2N2MSlnWXZEdMNDZzQWe5MDZzMmdZJTO1R2RWVHZDljekhkSsl1VwYnWtx2cihVT2pVbWtWWq5EbNpGZr1ERNVzTEdGeZpXQ18EVklWWXlFNZdlUp5EVSlmT6NWP:1716918432:139.135.39.16:c8f8ea8d32eb9861fda9de6379c3bf47499e46a5fe2930ddad718fddfbaec81f/index.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Premam%20(Chitralahari)&img=https://image.tmdb.org/t/p/original/hqlyUXs5KqcmvpisRIUE3SyAxEX.jpg",
});
mapRedirect(["crew", "1045931"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/4kX80Ea98cEy2Ahy0LSMYtFvJDG.jpg",
    title: "Watch Crew",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/c80ea7bee6b9ca5ade6519b1f3e772f02753eaa36cd890f43fe0765d75dce6463515bcf393d246179cae354a8cbb289ffe90091d5a87b85d1af3fe936451b53b5d40fe137ea21899d71bc6ac4fc527c2c411a284a7b80ea1fc3cb398b2b4ff11197761411b230eaccc69362ba6d32a736952a07aa874b72c800a7a2d9d95b678/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Crew&img=https://image.tmdb.org/t/p/original/fAMUZbFs9tDqOCzqaa7tTEoqQwG.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/c80ea7bee6b9ca5ade6519b1f3e772f02753eaa36cd890f43fe0765d75dce6463515bcf393d246179cae354a8cbb289ffe90091d5a87b85d1af3fe936451b53b5d40fe137ea21899d71bc6ac4fc527c2c411a284a7b80ea1fc3cb398b2b4ff11197761411b230eaccc69362ba6d32a736952a07aa874b72c800a7a2d9d95b678/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Crew&img=https://image.tmdb.org/t/p/original/fAMUZbFs9tDqOCzqaa7tTEoqQwG.jpg",
});
mapRedirect(["arthur-christmas", "51052"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/9iBfNsWAIk7Yth9lv9RV5dhCLnl.jpg",
    title: "Watch Arthur Christmas",
    video: "https://toonstream.day/?trembed=0&trid=3156&trtype=1",
    video2: "https://toonstream.day/?trembed=0&trid=3156&trtype=1",
});
mapRedirect(["eagle-hindi", "1150478"], {
    splashimgurl: "https://assets-in.bmscdn.com/discovery-catalog/events/et00361924-fhscxtcfqt-landscape.jpg",
    title: "Watch Eagle - Hindi Dubbed",
    video: "https://okmalayalam.org/bewab/8.php?url=https://teamomw5.com/hls/xwwm2bfopegqkov2bs4uai6aup2c7xjehmul4pmzt,6uxuyiajafyevjjvo4q,wuxuyiajafwtzjgtk2q,.urlset/master.m3u8",
    video2: "https://okmalayalam.org/bewab/8.php?url=https://teamomw5.com/hls/xwwm2bfopegqkov2bs4uai6aup2c7xjehmul4pmzt,6uxuyiajafyevjjvo4q,wuxuyiajafwtzjgtk2q,.urlset/master.m3u8",
});
mapRedirect(["dolittle-hindi", "448119"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2cbUXan4QUY1QoVnhhunJqpKR8y.jpg",
    title: "Watch Dolittle - Hindi Dubbed",
    video: "series.html?source=&subcode=en&substitleurl=substitles/series-sub.srt&title-1=&img=",
    video2: "series2.html?source=&subcode=en&substitleurl=substitles/series-sub.srt&title-1=&img=",
});
mapRedirect(["the-beekeeper", "866398"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/1vWI4E9Qf135X2cr2AJOZ0CcWS7.jpg",
    title: "Watch The Beekeeper",
    video: "series.html?source=https://ab.bigtimedelivery.net/_v13/9d63e6f64090b701b78d116d38498e864bdfe09b00585059eff26ab891ed0567102b9859eecfb771a82dbedd8de3dbf44a9a2fede70ebe67f096148fb4ef0e3c8f2258eef563fac468bb38185040d6e7552414dc4db0256cba41a2722793a3ccde399f02d768afcb68aeefa322fd491ee2abbe0ca1a547d84cf117fdb1bee037f034a835eec8ddfa54bb30ed14669628/playlist.m3u8&subcode=en&substitleurl=substitles/movies/the-beekeeper-en.srt&title-1=The Beekeeper&img=https://image.tmdb.org/t/p/original/1vWI4E9Qf135X2cr2AJOZ0CcWS7.jpg",
    video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/9d63e6f64090b701b78d116d38498e864bdfe09b00585059eff26ab891ed0567102b9859eecfb771a82dbedd8de3dbf44a9a2fede70ebe67f096148fb4ef0e3c8f2258eef563fac468bb38185040d6e7552414dc4db0256cba41a2722793a3ccde399f02d768afcb68aeefa322fd491ee2abbe0ca1a547d84cf117fdb1bee037f034a835eec8ddfa54bb30ed14669628/playlist.m3u8&subcode=en&substitleurl=substitles/movies/the-beekeeper-en.srt&title-1=The Beekeeper&img=https://image.tmdb.org/t/p/original/1vWI4E9Qf135X2cr2AJOZ0CcWS7.jpg",
});
mapRedirect(["upgraded", "1014590"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/a9zrE1uqnYI305tGNcztZPCrCO8.jpg",
    title: "Watch Upgraded",
    video: "series.html?source=https://aj.bigtimedelivery.net/_v13/78d39d21f2747bd48ea02b3f325cb39bf653ef3c3a904ed42c82f21208cf0180bd39aa3692ed26b4bc4ac6e19686f238f023dc0a300efd40534e2d6a1c761a04ad2ab7cbd3461ac2999f32202556207d9fe3b29b5eecbed6e70c64354e6451f101488517a0dbe227c975eca18696da4c8c1fb02f151ccdaf7ce51cff92f03c08590e899582234ce208ed21f41cf345a6/playlist.m3u8&subcode=en&substitleurl=substitles/movies/upgraded.srt&title-1=&img=https://image.tmdb.org/t/p/original/a9zrE1uqnYI305tGNcztZPCrCO8.jpg",
    video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/78d39d21f2747bd48ea02b3f325cb39bf653ef3c3a904ed42c82f21208cf0180bd39aa3692ed26b4bc4ac6e19686f238f023dc0a300efd40534e2d6a1c761a04ad2ab7cbd3461ac2999f32202556207d9fe3b29b5eecbed6e70c64354e6451f101488517a0dbe227c975eca18696da4c8c1fb02f151ccdaf7ce51cff92f03c08590e899582234ce208ed21f41cf345a6/playlist.m3u8&subcode=en&substitleurl=substitles/movies/upgraded.srt&title-1=&img=https://image.tmdb.org/t/p/original/a9zrE1uqnYI305tGNcztZPCrCO8.jpg",
});
mapRedirect(["gangubai-kathiawadi", "664332"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/mXFTnxKag2IYJyF1LFQHP0U95xY.jpg",
    title: "Watch Gangubai Kathiawadi",
    video: "series.html?source=https://ah.bigtimedelivery.net/_v13/bd7b3ee276181600b5eb6e5b7580e083001f4b6fc38e48ccc7261eb6cf57a6c15dd9b3e46d40d5440100bf267e9304aa17ccaf4e9114fa94b76a2ee7f343d431062ad634dc5f8fcbc4844b7458df4416c836f08861506409d0fed1ee200a95574a14ff5af4643f6cc7db753d15a7506922d185a62141f2e63b3833235c092b392deca8f05971ee1a7854c60b3e7e58cf/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Gangubai Kathiawadi&img=https://image.tmdb.org/t/p/original/mXFTnxKag2IYJyF1LFQHP0U95xY.jpg",
    video2: "series2.html?source=https://ah.bigtimedelivery.net/_v13/bd7b3ee276181600b5eb6e5b7580e083001f4b6fc38e48ccc7261eb6cf57a6c15dd9b3e46d40d5440100bf267e9304aa17ccaf4e9114fa94b76a2ee7f343d431062ad634dc5f8fcbc4844b7458df4416c836f08861506409d0fed1ee200a95574a14ff5af4643f6cc7db753d15a7506922d185a62141f2e63b3833235c092b392deca8f05971ee1a7854c60b3e7e58cf/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Gangubai Kathiawadi&img=https://image.tmdb.org/t/p/original/mXFTnxKag2IYJyF1LFQHP0U95xY.jpg",
});
mapRedirect(["dunki", "960876"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/3GnSb19ePZSqpoS4jFfCm5gf054.jpg",
    title: "Watch Dunki 2023",
    video: "series.html?source=https://ae.bigtimedelivery.net/_v13/e8033a77b9c876238ba9591d092a4bcbec5d6fceae8670f98ede98cb0b6bf73850cce4a087c5901702253391821df76f67ee346e64f721a06f6eb112c5afcf1388b824de8f7aaa303f938cd8cd2e2655f314d331488b8e50de19cf54ecf856684be8f48ecf87be128f74a8fd7092faf10b7842eb27924816516727c9ce277e16df4fb146e55a7b32f3d70bcc04ad2261/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Dunki&img=https://image.tmdb.org/t/p/original/npUfK8RuTqabJlOzWu8Ye4or2jn.jpg",
    video2: "series2.html?source=https://ae.bigtimedelivery.net/_v13/e8033a77b9c876238ba9591d092a4bcbec5d6fceae8670f98ede98cb0b6bf73850cce4a087c5901702253391821df76f67ee346e64f721a06f6eb112c5afcf1388b824de8f7aaa303f938cd8cd2e2655f314d331488b8e50de19cf54ecf856684be8f48ecf87be128f74a8fd7092faf10b7842eb27924816516727c9ce277e16df4fb146e55a7b32f3d70bcc04ad2261/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Dunki&img=https://image.tmdb.org/t/p/original/npUfK8RuTqabJlOzWu8Ye4or2jn.jpg",
});
mapRedirect(["wild-wild-punjab", "1252455"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/exQYRPzUv1nuLZtqmR8a8C91KqT.jpg",
    title: "Watch Wild Wild Punjab",
    video: "series.html?source=https://ah.bigtimedelivery.net/_v13/2e5636c78c7515bb5d8aeecd8d9073221c633dbdf710497bd01a4243290da4166d0fb7babbc317fb0087ef683aec251b8beae640401110b99e639ca11b740177214826581f69ba496a1ef64ce0b7b19ab3ce1858cb7f0a008ddb6f60baf214acaba3ec901a96e26d636bec06947d79ba75f60364b639cba5362131f7c9b91e8d/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Wild Wild Punjab&img=https://image.tmdb.org/t/p/original/cVWnFTK71jfqNfAVeSyM7n6wTWV.jpg",
    video2: "series2.html?source=https://ah.bigtimedelivery.net/_v13/2e5636c78c7515bb5d8aeecd8d9073221c633dbdf710497bd01a4243290da4166d0fb7babbc317fb0087ef683aec251b8beae640401110b99e639ca11b740177214826581f69ba496a1ef64ce0b7b19ab3ce1858cb7f0a008ddb6f60baf214acaba3ec901a96e26d636bec06947d79ba75f60364b639cba5362131f7c9b91e8d/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Wild Wild Punjab&img=https://image.tmdb.org/t/p/original/cVWnFTK71jfqNfAVeSyM7n6wTWV.jpg",
});
mapRedirect(["pind-aala-school", "1312563"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/ktCCRwifr4XHpfKvnphCe1F4hUd.jpg",
    title: "Watch Pind Aala School",
    video: "series.html?source=https://ab.bigtimedelivery.net/_v13/d6c7786df7dec520f751d191cb71a22df352aa8373a187d0ce41e0b0d60b4ce9271aba6d0a3becc50100d912522650a3fff7381b56d43b564cd44b385ad6a472de9a69af577da733941d5d11344e36072db2578e917a14fe3e327e3ee457faf6f54c0043ae036f1800851f4d6cddc2f41fdcc98413d5ce62d359552b09f0a79e/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Pind Aala School&img=https://image.tmdb.org/t/p/original/ktCCRwifr4XHpfKvnphCe1F4hUd.jpg",
    video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/d6c7786df7dec520f751d191cb71a22df352aa8373a187d0ce41e0b0d60b4ce9271aba6d0a3becc50100d912522650a3fff7381b56d43b564cd44b385ad6a472de9a69af577da733941d5d11344e36072db2578e917a14fe3e327e3ee457faf6f54c0043ae036f1800851f4d6cddc2f41fdcc98413d5ce62d359552b09f0a79e/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Pind Aala School&img=https://image.tmdb.org/t/p/original/ktCCRwifr4XHpfKvnphCe1F4hUd.jpg",
});
mapRedirect(["shinda-shinda-no-papa", "1285827"], {
    splashimgurl: "https://assets-in.bmscdn.com/discovery-catalog/events/et00337909-yufwtqgwck-landscape.jpg",
    title: "Watch Shinda Shinda No Papa (2024)",
    video: "https://ok.ru/videoembed/7290801818150",
    video2: "https://ok.ru/videoembed/7290801818150",
});
mapRedirect(["chal-mera-putt", "617483"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/t2PSDMHqYmeW4OCuIcEJ64lN1Kr.jpg",
    title: "Watch Chal Mera Putt",
    video: "https://cdn.asumanaksoy.com/video/277281aada22045c03945dcb2ca6f2ec",
    video2: "https://cdn.asumanaksoy.com/video/277281aada22045c03945dcb2ca6f2ec",
});
mapRedirect(["chal-mera-putt-2", "680956"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/t2PSDMHqYmeW4OCuIcEJ64lN1Kr.jpg",
    title: "Watch Chal Mera Putt 2",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8i2rxj",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8i2rxj",
});
mapRedirect(["chal-mera-putt-3", "878667"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/t2PSDMHqYmeW4OCuIcEJ64lN1Kr.jpg",
    title: "Watch Chal Mera Putt 3",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8pt6f5",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8pt6f5",
});
mapRedirect(["rocky-aur-rani-kii-prem-kahaani", "848116"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/bynRHBHqxkWk0HU2sYXKtz9HYxF.jpg",
    title: "Watch Rocky Aur Rani Kii Prem Kahaani",
    video: "series.html?source=&subcode=en&substitleurl=substitles/series-sub.srt&title-1=&img=",
    video2: "series2.html?source=&subcode=en&substitleurl=substitles/series-sub.srt&title-1=&img=",
});
mapRedirect(["jatt-&-juliet-3", "1184243-3"], {
    splashimgurl: "https://assets-in.bmscdn.com/discovery-catalog/events/et00370091-ypgukrwjer-landscape.jpg",
    title: "Watch Jatt & Juliet 3 (2024)",
    video: "https://ok.ru/videoembed/7416085940774",
    video2: "https://ok.ru/videoembed/7416085940774",
});
mapRedirect(["morbius", "526896"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/gG9fTyDL03fiKnOpf2tr01sncnt.jpg",
    title: "Watch Morbius English Subtitle",
    video: "series.html?source=https://ag.bigtimedelivery.net/_v13/c0ff3581bb4d37a817d1b6570d5fbd7f6c06993c24b12a33b55a194ff23952b7e9b85d1b6dffd0455aa285c1cfcdcf3ad51b4e41aec0179ae6e71c8b38bd05c78f5fe79d412cfa017d8fdf344d23e6ac26736c2aaf1ae5566a5d216bcbaf9d34c580185a3041b0dbc8cabcfb23271cd10078fd3193a61c4a4299d1ff26e4f89bb8d1d1620c91beacde40ac384a1c84a4/playlist.m3u8&subcode=en&substitleurl=substitles/movies/morbius-en.srt&title-1=Morbius&img=https://image.tmdb.org/t/p/original/13H4py1ckc6pKydF6a7J7n4P2Fu.jpg",
    video2: "series2.html?source=https://ag.bigtimedelivery.net/_v13/c0ff3581bb4d37a817d1b6570d5fbd7f6c06993c24b12a33b55a194ff23952b7e9b85d1b6dffd0455aa285c1cfcdcf3ad51b4e41aec0179ae6e71c8b38bd05c78f5fe79d412cfa017d8fdf344d23e6ac26736c2aaf1ae5566a5d216bcbaf9d34c580185a3041b0dbc8cabcfb23271cd10078fd3193a61c4a4299d1ff26e4f89bb8d1d1620c91beacde40ac384a1c84a4/playlist.m3u8&subcode=en&substitleurl=substitles/movies/morbius-en.srt&title-1=Morbius&img=https://image.tmdb.org/t/p/original/13H4py1ckc6pKydF6a7J7n4P2Fu.jpg",
});
mapRedirect(["john-wick", "245891"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/pskMwjxLcBLhCYRN3cKG5vPw76y.jpg",
    title: "Watch John Wick - English Subtitle",
    video: "series.html?source=https://ab.bigtimedelivery.net/_v13/c9af48f8162b44f53c370ac8c05a58fdf9731d129a9214db71a8cfe7e0537695a43779d86aca8067238fdb0d55bbbe8e4d76c1aaae4670cb078c37bca91983dbf3fd9447833a8f8a27948d1a86bc714a55e39e67803cb52e1c1f16ea126ffc522f5cddf5191bd12b263048827e5e0f2de2724721c506144a635511632dd0c232f2db5ddf8ba6b028e1d0a82538baab2a/playlist.m3u8&subcode=en&substitleurl=substitles/movies/john-wick-en.srt&title-1=John Wick&img=https://image.tmdb.org/t/p/original/wcQrQyUSJh8STq4JHMVW29M9Mew.jpg",
    video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/c9af48f8162b44f53c370ac8c05a58fdf9731d129a9214db71a8cfe7e0537695a43779d86aca8067238fdb0d55bbbe8e4d76c1aaae4670cb078c37bca91983dbf3fd9447833a8f8a27948d1a86bc714a55e39e67803cb52e1c1f16ea126ffc522f5cddf5191bd12b263048827e5e0f2de2724721c506144a635511632dd0c232f2db5ddf8ba6b028e1d0a82538baab2a/playlist.m3u8&subcode=en&substitleurl=substitles/movies/john-wick-en.srt&title-1=John Wick&img=https://image.tmdb.org/t/p/original/wcQrQyUSJh8STq4JHMVW29M9Mew.jpg",
});
mapRedirect(["john-wick-chapter-2", "324552"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/r17jFHAemzcWPPtoO0UxjIX0xas.jpg",
    title: "Watch John Wick: Chapter 2 - English Subtitle",
    video: "series.html?source=https://ag.bigtimedelivery.net/_v13/339248e26075734d35495aebbc1f6c397f00f14c966eef64bee3d56804d905fab71903a2b0ea96474f54ac8aefcd6dec27cdcb31dcd839c659f699d59beb07d2d467ce022634dbcae55ef0c486cfb3df3be4b6c7fe70fb9b9058e63bd5a3e0b6f321789636954c7e09ddc8f7e30d18c11a0d606ae1dc26e55f38535fad26c6e97c519cb4b5abefa951feba2a3766d9f4/playlist.m3u8&subcode=en&substitleurl=substitles/movies/john-wick-chapter-2-en.srt&title-1=John Wick: Chapter 2&img=https://image.tmdb.org/t/p/original/iU7LAN59vwKyaYta1FjjCXRRdrr.jpg",
    video2: "series2.html?source=https://ag.bigtimedelivery.net/_v13/339248e26075734d35495aebbc1f6c397f00f14c966eef64bee3d56804d905fab71903a2b0ea96474f54ac8aefcd6dec27cdcb31dcd839c659f699d59beb07d2d467ce022634dbcae55ef0c486cfb3df3be4b6c7fe70fb9b9058e63bd5a3e0b6f321789636954c7e09ddc8f7e30d18c11a0d606ae1dc26e55f38535fad26c6e97c519cb4b5abefa951feba2a3766d9f4/playlist.m3u8&subcode=en&substitleurl=substitles/movies/john-wick-chapter-2-en.srt&title-1=John Wick: Chapter 2&img=https://image.tmdb.org/t/p/original/iU7LAN59vwKyaYta1FjjCXRRdrr.jpg",
});
mapRedirect(["john-wick-chapter-3", "458156"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/jJRboW28xjnWecSkZ9LDA9fINLj.jpg",
    title: "Watch John Wick: Chapter 3 - Parabellum - English Subtitle",
    video: "series.html?source=https://aa.bigtimedelivery.net/_v13/a0c5a7e8a8831e74afa7760dce0fa3a8c2f0099398ba11a3bb91b16de6a1113346c09186353c69f2255b125f17c734554ffc84d9dbf9596fc348607e311ba9cab3e38e806a6cc250c011bed2d1ccf1c00ece960d832414ddf993cf603d0cafa5e703f8c93eb205f125c7d54bde06ea958768396468cc45576a2332f383618c435a940c745f9732086317c8e9edec5e89/playlist.m3u8&subcode=en&substitleurl=substitles/movies/john-wick-chapter-3-en.srt&title-1=John Wick: Chapter 3&img=https://image.tmdb.org/t/p/original/86EZWNycNbLz8OCXw5JYsN93hMs.jpg",
    video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/a0c5a7e8a8831e74afa7760dce0fa3a8c2f0099398ba11a3bb91b16de6a1113346c09186353c69f2255b125f17c734554ffc84d9dbf9596fc348607e311ba9cab3e38e806a6cc250c011bed2d1ccf1c00ece960d832414ddf993cf603d0cafa5e703f8c93eb205f125c7d54bde06ea958768396468cc45576a2332f383618c435a940c745f9732086317c8e9edec5e89/playlist.m3u8&subcode=en&substitleurl=substitles/movies/john-wick-chapter-3-en.srt&title-1=John Wick: Chapter 3&img=https://image.tmdb.org/t/p/original/86EZWNycNbLz8OCXw5JYsN93hMs.jpg",
});
mapRedirect(["john-wick-chapter-4", "603692"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/i3OTGmLNOZIo4SRQLVfLjeWegB6.jpg",
    title: "Watch John Wick: Chapter 4 - English Subtitle",
    video: "series.html?source=https://ab.bigtimedelivery.net/_v13/e87f231b367d9120fce53210c6d4d7e55a7a54764ca17a4b83ba8d354c8220d8953ba39d5a7662d491056ecb24e31a1a23f4e78ea5d6509da4265afff940c5e95ba23657fc4930446412a8215d3db8f66bc6903855bdc844bcebb764a0fa68a75fe57a372e3939ca4fd096a00951a80999881bdc120edfea0a2d23320ab621a53359c49fb46c00b9934b2304f5b4e639/playlist.m3u8&subcode=en&substitleurl=substitles/movies/john-wick-chapter-4-en.srt&title-1=John Wick: Chapter 4&img=https://image.tmdb.org/t/p/original/i8dshLvq4LE3s0v8PrkDdUyb1ae.jpg",
    video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/e87f231b367d9120fce53210c6d4d7e55a7a54764ca17a4b83ba8d354c8220d8953ba39d5a7662d491056ecb24e31a1a23f4e78ea5d6509da4265afff940c5e95ba23657fc4930446412a8215d3db8f66bc6903855bdc844bcebb764a0fa68a75fe57a372e3939ca4fd096a00951a80999881bdc120edfea0a2d23320ab621a53359c49fb46c00b9934b2304f5b4e639/playlist.m3u8&subcode=en&substitleurl=substitles/movies/john-wick-chapter-4-en.srt&title-1=John Wick: Chapter 4&img=https://image.tmdb.org/t/p/original/i8dshLvq4LE3s0v8PrkDdUyb1ae.jpg",
});
mapRedirect(["john-wick-hindi", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/pskMwjxLcBLhCYRN3cKG5vPw76y.jpg",
    title: "Watch John Wick - Hindi Dubbed",
    video: "https://archive.org/download/holly_hollywooder/John%20Wick%20%282014%29%20BluRay%201080p%20%20Dual%20Audio%20%5B%20Hindi%20%2B%20English%20%5D%20DD%205.1.mp4",
    video2: "https://archive.org/download/holly_hollywooder/John%20Wick%20%282014%29%20BluRay%201080p%20%20Dual%20Audio%20%5B%20Hindi%20%2B%20English%20%5D%20DD%205.1.mp4",
    enableDownload: true,
    download: "https://archive.org/download/holly_hollywooder/John%20Wick%20%282014%29%20BluRay%201080p%20%20Dual%20Audio%20%5B%20Hindi%20%2B%20English%20%5D%20DD%205.1.mp4",
});
mapRedirect(["john-wick-chapter-2-hindi", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/r17jFHAemzcWPPtoO0UxjIX0xas.jpg",
    title: "Watch John Wick: Chapter 2 - Hindi Dubbed",
    video: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9waW5rbWFuLnlkYzF3ZXMubWUvdi8wMi8wMDAwNC9idW1qamg0MHVrbzlfaC9Qcm1vdmllcy1Kb2huX1dpY2s6X0NoYXB0ZXJfMl9IaW5kaV9EdWJiZWQubXA0P3Q9M21hWklYZTZNU0ZZOWgxNlhibFpyQXRpc2hxTEVTTms4WXFBWkJEMTllayZhbXA7cz0xNzIxOTEyNzQ2JmFtcDtlPTIxNjAwJmFtcDtmPTIyNjk1JmFtcDtzcD01NDAmYW1wO2k9MC4w",
    video2: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9waW5rbWFuLnlkYzF3ZXMubWUvdi8wMi8wMDAwNC9idW1qamg0MHVrbzlfaC9Qcm1vdmllcy1Kb2huX1dpY2s6X0NoYXB0ZXJfMl9IaW5kaV9EdWJiZWQubXA0P3Q9M21hWklYZTZNU0ZZOWgxNlhibFpyQXRpc2hxTEVTTms4WXFBWkJEMTllayZhbXA7cz0xNzIxOTEyNzQ2JmFtcDtlPTIxNjAwJmFtcDtmPTIyNjk1JmFtcDtzcD01NDAmYW1wO2k9MC4w",
    enableDownload: true,
    download: "https://proxy.hdmovies2.online/?url=https://pinkman.ydc1wes.me/v/02/00004/bumjjh40uko9_h/Prmovies-John_Wick:_Chapter_2_Hindi_Dubbed.mp4?t=3maZIXe6MSFY9h16XblZrAtishqLESNk8YqAZBD19ek&s=1721912746&e=21600&f=22695&sp=540&i=0.0&download=force",
});
mapRedirect(["john-wick-chapter-3-hindi", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/jJRboW28xjnWecSkZ9LDA9fINLj.jpg",
    title: "Watch John Wick: Chapter 3 - Parabellum - Hindi Dubbed",
    video: "series.html?source=https://archive.org/download/holly_hollywooder/John.Wick.3.Parabellum.2019.4k.BluRay.Hindi.English.Moviesflix.mobi.mkv.mp4&subcode=en&substitleurl=substitles/movies/john-wick-chapter-3-en.srt&title-1=John Wick: Chapter 3&img=https://image.tmdb.org/t/p/original/86EZWNycNbLz8OCXw5JYsN93hMs.jpg",
    video2: "series2.html?source=https://archive.org/download/holly_hollywooder/John.Wick.3.Parabellum.2019.4k.BluRay.Hindi.English.Moviesflix.mobi.mkv.mp4&subcode=en&substitleurl=substitles/movies/john-wick-chapter-3-en.srt&title-1=John Wick: Chapter 3&img=https://image.tmdb.org/t/p/original/86EZWNycNbLz8OCXw5JYsN93hMs.jpg",
    enableDownload: true,
    download: "https://archive.org/download/holly_hollywooder/John.Wick.3.Parabellum.2019.4k.BluRay.Hindi.English.Moviesflix.mobi.mkv.mp4",
});
mapRedirect(["john-wick-chapter-4-hindi", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/i3OTGmLNOZIo4SRQLVfLjeWegB6.jpg",
    title: "Watch John Wick: Chapter 4 - Hindi Dubbed",
    video: "series.html?source=https://archive.org/download/VideshiPicturesStartWithJ1/John_Wick_Chapter_4_Final_2023_1080_Hindi_6CH_Eng_6CH_Action_Thriller.mp4&subcode=en&substitleurl=substitles/movies/john-wick-chapter-4-en.srt&title-1=John Wick: Chapter 4&img=https://image.tmdb.org/t/p/original/i8dshLvq4LE3s0v8PrkDdUyb1ae.jpg",
    video2: "series2.html?source=https://archive.org/download/VideshiPicturesStartWithJ1/John_Wick_Chapter_4_Final_2023_1080_Hindi_6CH_Eng_6CH_Action_Thriller.mp4&subcode=en&substitleurl=substitles/movies/john-wick-chapter-4-en.srt&title-1=John Wick: Chapter 4&img=https://image.tmdb.org/t/p/original/i8dshLvq4LE3s0v8PrkDdUyb1ae.jpg",
    enableDownload: true,
    download: "https://archive.org/download/VideshiPicturesStartWithJ1/John_Wick_Chapter_4_Final_2023_1080_Hindi_6CH_Eng_6CH_Action_Thriller.mp4",
});
mapRedirect(["radius-hindi", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/tR6MAzTkgmXNJjwuxWtXYfQWwCv.jpg",
    title: "Watch Radius - Hindi Dubbed",
    video: "series.html?source=&subcode=en&substitleurl=substitles/series-sub.srt&title-1=&img=",
    video2: "series2.html?source=&subcode=en&substitleurl=substitles/series-sub.srt&title-1=&img=",
});
mapRedirect(["lucy-hindi", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/ozVwXlfxqNsariipatGwa5px3Pm.jpg",
    title: "Watch Lucy Hindi Dubbed",
    video: "series.html?source=https://ia802309.us.archive.org/13/items/lucy-480p/Lucy480pdual.mp4&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Lucy&img=https://image.tmdb.org/t/p/original/8VbO71FMmddMiLrjEdrvO7ja1Aj.jpg",
    video2: "series2.html?source=https://ia802309.us.archive.org/13/items/lucy-480p/Lucy480pdual.mp4&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Lucy&img=https://image.tmdb.org/t/p/original/8VbO71FMmddMiLrjEdrvO7ja1Aj.jpg",
});
mapRedirect(["bad-tutor", "509563"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/3fcJTOAQuzJ6bPEITQk9NbVTDaH.jpg",
    title: "Watch Bad Tutor",
    video: "series.html?source=https://ab.bigtimedelivery.net/_v13/5a04e67c8340332cf1ed8b6b627e89237af91f488c54dfab77979d529f49f8b1ac6e5b929612e7148d8f51b516f166659233f0edac0841e77a8b455e122b9833c04b018ac7729f3555b4c07b907b657f41e6edbce61b9f2de9e8d84c71aac047709fd90ff33f3a54eefbdefd818bb2dbaba2d5e01e20539edba50ee5cf97d688faf3cd9992daa56d7a3ce8091172fe9c/playlist.m3u8&subcode=en&substitleurl=substitles/movies/bad-tutor-en.srt&title-1=Bad Tutor&img=https://image.tmdb.org/t/p/original/9vLQhYKH3OKuhLRCbfaMd5OTMJQ.jpg",
    video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/5a04e67c8340332cf1ed8b6b627e89237af91f488c54dfab77979d529f49f8b1ac6e5b929612e7148d8f51b516f166659233f0edac0841e77a8b455e122b9833c04b018ac7729f3555b4c07b907b657f41e6edbce61b9f2de9e8d84c71aac047709fd90ff33f3a54eefbdefd818bb2dbaba2d5e01e20539edba50ee5cf97d688faf3cd9992daa56d7a3ce8091172fe9c/playlist.m3u8&subcode=en&substitleurl=substitles/movies/bad-tutor-en.srt&title-1=Bad Tutor&img=https://image.tmdb.org/t/p/original/9vLQhYKH3OKuhLRCbfaMd5OTMJQ.jpg",
});
mapRedirect(["parinda-paar-geyaa", "1181534"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/uQz4zWvBRRZvWO5oi1OcdP3SC7Z.jpg",
    title: "Watch Parinda Paar Geyaa",
    video: "https://mixdrop.ps/e/1vk4lw8qcq0k9z",
    video2: "series2.html?source=https://parrot.tvlogy.to/zrVvCCJc94Q7f3geNenL4OFYDnHVCiu3gpff7yCjlfAtZCvjl4fLJEFCfSqK-in_O7ZzCVBjHwSk_k9bgfGEbaiepWSQsec6Kyzond58lJmOpH2-2OSmPbmxhfLNWu3xPcTIDjuKBxTKShWSDv-UVIMr4sxQHmIqm4j3V8GWIZWOZ1FCpBRqC99wauwvEV_4OjfCp8HlBwVgmXgl2h6LfzZXhky1Ri2yCb9xoBP9qUA/0aLxE7zFtWN_Uwe7bplSN9_68DIX6ESV81YIaTwu3oY/video.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Parinda Paar Geyaa&img=https://image.tmdb.org/t/p/original/uQz4zWvBRRZvWO5oi1OcdP3SC7Z.jpg",
});
mapRedirect(["", "464293"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lbxvZ4jooF6zHkC7fTeOCCaUhbe.jpg",
    title: "Watch The Legend Of Maula Jatt",
    video: "https://glowsvox.com/bewab/8.php?url=https://teamomw5.com/hls/xwwm2ufgpegqkov2bs6uazokvdjkijx3fekgq62hw,ubgirwg7kw2ae3e7lwq,4bgirwg7kwqsg4drgda,.urlset/master.m3u8",
    video2: "series2.html?source=https://dusk.tvlogy.to/8iBLbq0KxcovwWQ_LYleG9hx3TCFR3BDvRjLV6Tk6FNnSvSqgaxfC-XYSjE_AYdGLbn9STRCqgM196YWDdwHBp1S-aC2vD7GyweyzucWPdFUDGwPJ0LE8-6gOdfHy9Nv7a2yBVS8tUI5tVc4VMX_kapBgKp7HpRvxyXdZM3jguX8KmpO48oi-D9HiEDXN7M5wbMfJ4fdkZTYNI4paQEg4-LQPOaquCZWaKJsqOQeVz8/isQ60Nuk2r6TSOcK2T3O185eGVNLo-cbnHNbnIbydCQ/video.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=The Legend Of Maula Jatt&img=https://image.tmdb.org/t/p/original/lbxvZ4jooF6zHkC7fTeOCCaUhbe.jpg",
});
mapRedirect(["", ""], {
    splashimgurl: "",
    title: "Watch ",
    video: "series.html?source=&subcode=en&substitleurl=substitles/series-sub.srt&title-1=&img=",
    video2: "series2.html?source=&subcode=en&substitleurl=substitles/series-sub.srt&title-1=&img=",
});
mapRedirect(["", ""], {
    splashimgurl: "",
    title: "Watch ",
    video: "series.html?source=&subcode=en&substitleurl=substitles/series-sub.srt&title-1=&img=",
    video2: "series2.html?source=&subcode=en&substitleurl=substitles/series-sub.srt&title-1=&img=",
});
//Movies Ending

// mapRedirect(["law-1", "214303"], {
//     splashimgurl: "https://image.tmdb.org/t/p/original/i3OTGmLNOZIo4SRQLVfLjeWegB6.jpg",
//     title: "Watch Law & Order Season 01 Episode 1",
//     video: "series.html?source=https://ab.bigtimedelivery.net/_v13/e87f231b367d9120fce53210c6d4d7e55a7a54764ca17a4b83ba8d354c8220d8953ba39d5a7662d491056ecb24e31a1a23f4e78ea5d6509da4265afff940c5e95ba23657fc4930446412a8215d3db8f66bc6903855bdc844bcebb764a0fa68a75fe57a372e3939ca4fd096a00951a80999881bdc120edfea0a2d23320ab621a53359c49fb46c00b9934b2304f5b4e639/playlist.m3u8&subcode=en&substitleurl=substitles/movies/john-wick-chapter-4-en.srt&title-1=Law And Order S1 EP1&img=https://image.tmdb.org/t/p/original/84sFzAa4Gea3r2Zh6Qg2lxuJPMO.jpg",
// });
// mapRedirect(["law-2", "214304"], {
//     splashimgurl: "https://image.tmdb.org/t/p/original/i3OTGmLNOZIo4SRQLVfLjeWegB6.jpg",
//     title: "Watch Law & Order Season 01 Episode 2",
//     video: "series.html?source=https://ab.bigtimedelivery.net/_v13/e87f231b367d9120fce53210c6d4d7e55a7a54764ca17a4b83ba8d354c8220d8953ba39d5a7662d491056ecb24e31a1a23f4e78ea5d6509da4265afff940c5e95ba23657fc4930446412a8215d3db8f66bc6903855bdc844bcebb764a0fa68a75fe57a372e3939ca4fd096a00951a80999881bdc120edfea0a2d23320ab621a53359c49fb46c00b9934b2304f5b4e639/playlist.m3u8&subcode=en&substitleurl=substitles/movies/john-wick-chapter-4-en.srt&title-1=Law And Order S1 EP2&img=https://image.tmdb.org/t/p/original/cD9PxbrdWYgL7MUpD9eOYuiSe2P.jpg",
// });
// mapRedirect(["law-3", "214305"], {
//     splashimgurl: "https://image.tmdb.org/t/p/original/i3OTGmLNOZIo4SRQLVfLjeWegB6.jpg",
//     title: "Watch Law & Order Season 01 Episode 3",
//     video: "series.html?source=https://ab.bigtimedelivery.net/_v13/e87f231b367d9120fce53210c6d4d7e55a7a54764ca17a4b83ba8d354c8220d8953ba39d5a7662d491056ecb24e31a1a23f4e78ea5d6509da4265afff940c5e95ba23657fc4930446412a8215d3db8f66bc6903855bdc844bcebb764a0fa68a75fe57a372e3939ca4fd096a00951a80999881bdc120edfea0a2d23320ab621a53359c49fb46c00b9934b2304f5b4e639/playlist.m3u8&subcode=en&substitleurl=substitles/movies/john-wick-chapter-4-en.srt&title-1=Law And Order S1 EP3&img=https://image.tmdb.org/t/p/original/hib8MpBPU7GdluS38htXCF4uw0c.jpg",
// });
// mapRedirect(["law-4", "214306"], {
//     splashimgurl: "https://image.tmdb.org/t/p/original/i3OTGmLNOZIo4SRQLVfLjeWegB6.jpg",
//     title: "Watch Law & Order Season 01 Episode 4",
//     video: "series.html?source=https://ab.bigtimedelivery.net/_v13/e87f231b367d9120fce53210c6d4d7e55a7a54764ca17a4b83ba8d354c8220d8953ba39d5a7662d491056ecb24e31a1a23f4e78ea5d6509da4265afff940c5e95ba23657fc4930446412a8215d3db8f66bc6903855bdc844bcebb764a0fa68a75fe57a372e3939ca4fd096a00951a80999881bdc120edfea0a2d23320ab621a53359c49fb46c00b9934b2304f5b4e639/playlist.m3u8&subcode=en&substitleurl=substitles/movies/john-wick-chapter-4-en.srt&title-1=Law And Order S1 EP4&img=",
// });
// mapRedirect(["law-5", "214307"], {
//     splashimgurl: "https://image.tmdb.org/t/p/original/i3OTGmLNOZIo4SRQLVfLjeWegB6.jpg",
//     title: "Watch Law & Order Season 01 Episode 5",
//     video: "series.html?source=https://ab.bigtimedelivery.net/_v13/e87f231b367d9120fce53210c6d4d7e55a7a54764ca17a4b83ba8d354c8220d8953ba39d5a7662d491056ecb24e31a1a23f4e78ea5d6509da4265afff940c5e95ba23657fc4930446412a8215d3db8f66bc6903855bdc844bcebb764a0fa68a75fe57a372e3939ca4fd096a00951a80999881bdc120edfea0a2d23320ab621a53359c49fb46c00b9934b2304f5b4e639/playlist.m3u8&subcode=en&substitleurl=substitles/movies/john-wick-chapter-4-en.srt&title-1=Law And Order S1 EP5&img=",
// });
//TV Shows
//Episodes
mapRedirect(["mehmed-the-conqueror-ep33"], {
    splashimgurl: "https://images.justwatch.com/backdrop/148279962/s640/mehmed-the-conqueror/mehmed-the-conqueror",
    title: "Watch Mehmed The Conqueror Episode 33(Last) With Urdu Dubbed",
    video: "series.html?source=https://cdn6.niazitv.pk/Turkish-Dramas-NiaziTV-App-2/Mehmed-The-Conqueror-Urdu-Dubbed/Last-Episode-33.mp4/index.m3u8?token=VaXX9BEYbBh_tXXkGpqEltNztj-_3o2Rr1SnCRD_cFrARR4RS6eIfsONhXKLUMiy&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mehmed Ep 33&img=https://i.pinimg.com/originals/de/3c/4a/de3c4aa44d4a72aef1608b4315ddc9fd.jpg",
});
mapRedirect(["mendirman-jaloliddin-s2-ep17"], {
    splashimgurl: "https://www.themoviedb.org/t/p/w780/3tjoK15v8SuY6ms6nKDtTnWjSuB.jpg",
    title: "Watch Mendirman Jaloliddin Episode 17(Last) With Urdu Subtitle",
    video: "series.html?source=https://cdn5.niazitv.pk/Turkish-Dramas-NiaziTV-App-2/Jalaudin-Season-2/Last-Episode-17.mp4/index.m3u8?token=VaXX9BEYbBh_tXXkGpqEltNztj-_3o2Rr1SnCRD_cFpoTfsOJDqovGf8UpiMH4ay&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Jaloliddin Ep 17&img=https://m.media-amazon.com/images/M/MV5BZTU4NmRmYjEtYTRkMC00MWRhLTgxNGQtMzhjZGI4OTY0MTFhXkEyXkFqcGdeQXVyMTE5OTk0OTA1._V1_.jpg",
});
mapRedirect(["ates-kuslari-s2-ep41"], {
    splashimgurl: "https://en.masa.news/uploads/thumbs/50be6d023-1.jpg",
    title: "Watch Ates Kuslari Season 02 Episode 41 With Urdu Substitle",
    video: "series.html?source=https://cdn6.niazitv.pk/Turkish-Dramas-NiaziTV-App-2/Ates-Kuslari-S2/Episode-41-BS.mp4/index.m3u8?token=VaXX9BEYbBh_tXXkGpqEltNztj-_3o2Rr1SnCRD_cFozrLS7jMVf4sogAJVJBMXR&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Ates Kuslari Ep 41&img=https://img.rgstatic.com/content/show/dbce1ba7-d138-49a0-ad34-350684b04374/backdrop-1280.jpg",
});

//All of us are dead
mapRedirect(["all-of-us-are-dead-s1-ep1"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 1 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/e64d5ab12afdd28462b51d56bb94004b0d9fa19a6de6a57033e90ca9c566f4b51848d2eb8c2963c9d0d8b9af22fb21e53dcca033b44d59975e81c997bb759bd5820fc9cdd9d7478ab0633fa2edcd240c834c4a51a44ff32b6af9d9dc9b5d66521d7aa891f2501d89505a3615a696c1f1892e96f382e1890ff95739e67aec602d6efdcc59efdd87e3bee7c85209f22518/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep1.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep1&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/e64d5ab12afdd28462b51d56bb94004b0d9fa19a6de6a57033e90ca9c566f4b51848d2eb8c2963c9d0d8b9af22fb21e53dcca033b44d59975e81c997bb759bd5820fc9cdd9d7478ab0633fa2edcd240c834c4a51a44ff32b6af9d9dc9b5d66521d7aa891f2501d89505a3615a696c1f1892e96f382e1890ff95739e67aec602d6efdcc59efdd87e3bee7c85209f22518/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep1.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep1&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
});
mapRedirect(["all-of-us-are-dead-s1-ep2"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 2 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/2a6f0e21332d6761fc31c3835bafef0bf059e48976b13179247f7b3cdd256b1dfe88d9002a5fb6c13713b0e7469403d858ea198ad1d79ed59152f855eaa3a405385b220bfa2a4486842f1dccb2bb91e3d8e956fd5bc2c4d6e77f29a075d3b2703d989c08fb5e1a8ddbf8105857a1f12ee40f1de5921719375921ccfebd2d46744be037a207700aeebc256916ec96ea43/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep2.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep2&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/2a6f0e21332d6761fc31c3835bafef0bf059e48976b13179247f7b3cdd256b1dfe88d9002a5fb6c13713b0e7469403d858ea198ad1d79ed59152f855eaa3a405385b220bfa2a4486842f1dccb2bb91e3d8e956fd5bc2c4d6e77f29a075d3b2703d989c08fb5e1a8ddbf8105857a1f12ee40f1de5921719375921ccfebd2d46744be037a207700aeebc256916ec96ea43/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep2.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep2&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
});
mapRedirect(["all-of-us-are-dead-s1-ep3"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 3 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/e45340182f7f0241d4d5f3f91c0fd2f071f02c6aa9aa4b528812dc670f9d276030cfcd25391652440f9f9881f1410d1635c031e86e3c5c98943ffbd0004d3604231237ed0b87060febf79d3af28462ec1c54c20fc8eda9958318d92a065cf32cc8e924473172079b00519e21494f8685d3298f7463c229efa024002546a1a6def1c72921f296faba57779f9f522f74b9/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep3.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep3&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/e45340182f7f0241d4d5f3f91c0fd2f071f02c6aa9aa4b528812dc670f9d276030cfcd25391652440f9f9881f1410d1635c031e86e3c5c98943ffbd0004d3604231237ed0b87060febf79d3af28462ec1c54c20fc8eda9958318d92a065cf32cc8e924473172079b00519e21494f8685d3298f7463c229efa024002546a1a6def1c72921f296faba57779f9f522f74b9/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep3.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep3&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
});
mapRedirect(["all-of-us-are-dead-s1-ep4"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 4 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/d4c03867d60ae03b253b801a77126016b2b2be1f99cd7fa32aa6f80276cc6faa1459467d732579580acdfd13549050e7796c6a6580cb71558a9a2b92c803c46fcfdcb447cd6cbc5b67ac6124ed2b4bc1f395b9ba6b85e93afde6e4c01ecf53104e90a2e3ed732a47f04a50133a8ad186e25cfd8ededd823bddf4dd1cd836d3a0d7673fb5cda5a9f71a85c17afcb0ed5f/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep4.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep4&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/d4c03867d60ae03b253b801a77126016b2b2be1f99cd7fa32aa6f80276cc6faa1459467d732579580acdfd13549050e7796c6a6580cb71558a9a2b92c803c46fcfdcb447cd6cbc5b67ac6124ed2b4bc1f395b9ba6b85e93afde6e4c01ecf53104e90a2e3ed732a47f04a50133a8ad186e25cfd8ededd823bddf4dd1cd836d3a0d7673fb5cda5a9f71a85c17afcb0ed5f/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep4.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep4&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
});
mapRedirect(["all-of-us-are-dead-s1-ep5"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 5 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/f1df55945a09c0a18320e3a0ba8dc8cf6c8ebe4e37015165e5196e695ccb5f44607c6feef23b86a910ed8bdf5d06f8acf38cd4a3198a0da2f5686217be1df49929aa34991ff9ec7ae52971ab29c1584237e8a0d6781c9eaed57f30c1be5ba29ae00722ef28720c0107bd7af00e9e66f47936e7632a9d59912a2611217dc65b8352355f9fdeabdbbfaa45e835d71b3a51/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep5.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep5&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/f1df55945a09c0a18320e3a0ba8dc8cf6c8ebe4e37015165e5196e695ccb5f44607c6feef23b86a910ed8bdf5d06f8acf38cd4a3198a0da2f5686217be1df49929aa34991ff9ec7ae52971ab29c1584237e8a0d6781c9eaed57f30c1be5ba29ae00722ef28720c0107bd7af00e9e66f47936e7632a9d59912a2611217dc65b8352355f9fdeabdbbfaa45e835d71b3a51/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep5.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep5&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
});
mapRedirect(["all-of-us-are-dead-s1-ep6"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 6 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/06be5413621b5a7a0f8f584704c4a06b5a77861a6e0b01c0ef5db1caceb2f99ade501f2a448d963e8db644555fa50c40e27387509d1780b40d4b6570f5cec785796a63b391ad655e96df35bc53861cecbaaa4b5239b204bed907fd31976adee5f3af86b7227578f120eec694a97f3cfc4f85b9462b04eab82d833de95ae11e8bae0483d4a7b324eb97b8960cdb1befa9/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep6.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep6&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/06be5413621b5a7a0f8f584704c4a06b5a77861a6e0b01c0ef5db1caceb2f99ade501f2a448d963e8db644555fa50c40e27387509d1780b40d4b6570f5cec785796a63b391ad655e96df35bc53861cecbaaa4b5239b204bed907fd31976adee5f3af86b7227578f120eec694a97f3cfc4f85b9462b04eab82d833de95ae11e8bae0483d4a7b324eb97b8960cdb1befa9/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep6.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep6&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
});
mapRedirect(["all-of-us-are-dead-s1-ep7"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 7 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/555d69e5f9a16c63a95abc52ab370d86bc3c1a00202e252f96f40b58f6607f34b02b4721e3201cf164ff270e3089cd13932ebda81cb290772ac95f2bf1267873fd980c7e76cc060dd33968dee9267d7ebd371820e73002e0759aad732e5ba7559c1d4be45a19e53f7e372c60527b1a75dd05dcd911c6276e7285507f578c631083deb6501a20212464ead10821f1cc01/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep7.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep7&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/555d69e5f9a16c63a95abc52ab370d86bc3c1a00202e252f96f40b58f6607f34b02b4721e3201cf164ff270e3089cd13932ebda81cb290772ac95f2bf1267873fd980c7e76cc060dd33968dee9267d7ebd371820e73002e0759aad732e5ba7559c1d4be45a19e53f7e372c60527b1a75dd05dcd911c6276e7285507f578c631083deb6501a20212464ead10821f1cc01/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep7.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep7&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
});
mapRedirect(["all-of-us-are-dead-s1-ep8"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 8 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/778976f94862d07b56d07a1910b83403bd859fa4d1604e84b8390655fa96df33736c0ed3a2e93b659ab06078bc8274ade6974696826a87e56d40f2216175230442269071147b44b90978a2c27f0643eaf09bc6d5123ddca2d862681fdc4a0eb252c698fa6630d0e6655b6e27d57ee71e8bdd9fb45999cd2d7cb3c973d0c5e32a4e257f41f798b85774f3ec788a9c2817/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep8.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep8&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/778976f94862d07b56d07a1910b83403bd859fa4d1604e84b8390655fa96df33736c0ed3a2e93b659ab06078bc8274ade6974696826a87e56d40f2216175230442269071147b44b90978a2c27f0643eaf09bc6d5123ddca2d862681fdc4a0eb252c698fa6630d0e6655b6e27d57ee71e8bdd9fb45999cd2d7cb3c973d0c5e32a4e257f41f798b85774f3ec788a9c2817/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep8.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep8&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
});
mapRedirect(["all-of-us-are-dead-s1-ep9"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 9 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/69d169992d90c85e9195ab0943a56cbb450b431b79d2b9dfcf6b69231e61bea44c07cee12e3a88fa407ea7fa428809095d7143807f582a83f3c5b3b3352fe765341faa88e3c2eb4e64ede519bbf4327ae6d6d4ddb6928427cee39c6d3a9fe6ffc30f2b5ef0d43fb9f432041a707f842f64960fa4ce0a187a332d88840bbf3020f94cca6e334fce41dfc05e05531540be/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep9.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep9&img=https://media.themoviedb.org/t/p/original/shdj51xhg74pl6ENL7YYeqmWFIG.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/69d169992d90c85e9195ab0943a56cbb450b431b79d2b9dfcf6b69231e61bea44c07cee12e3a88fa407ea7fa428809095d7143807f582a83f3c5b3b3352fe765341faa88e3c2eb4e64ede519bbf4327ae6d6d4ddb6928427cee39c6d3a9fe6ffc30f2b5ef0d43fb9f432041a707f842f64960fa4ce0a187a332d88840bbf3020f94cca6e334fce41dfc05e05531540be/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep9.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep9&img=https://media.themoviedb.org/t/p/original/shdj51xhg74pl6ENL7YYeqmWFIG.jpg",
});
mapRedirect(["all-of-us-are-dead-s1-ep10"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 10 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/2cf16d0a9bfcf682db7607b0cf606796694192da51dfedc57a98fed9667cb6c2e523342909eb770614b60fe746671b7699f5af1265bb5f91348408c151da65be4bbe9d70cee17f25f13ea7834bd33e6221ff21f024a3d894bdaee38d7809e0ac919ca2730f7e412ac06196a7f6382510ea37062db17bc47a442a22faa87b70e52bc630977b896d4ef99bdfffd50ce2fb/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep10.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep10&img=https://media.themoviedb.org/t/p/original/shdj51xhg74pl6ENL7YYeqmWFIG.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/2cf16d0a9bfcf682db7607b0cf606796694192da51dfedc57a98fed9667cb6c2e523342909eb770614b60fe746671b7699f5af1265bb5f91348408c151da65be4bbe9d70cee17f25f13ea7834bd33e6221ff21f024a3d894bdaee38d7809e0ac919ca2730f7e412ac06196a7f6382510ea37062db17bc47a442a22faa87b70e52bc630977b896d4ef99bdfffd50ce2fb/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep10.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep10&img=https://media.themoviedb.org/t/p/original/shdj51xhg74pl6ENL7YYeqmWFIG.jpg",
});
mapRedirect(["all-of-us-are-dead-s1-ep11"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 11 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/c9b63b200f43177fcc3258b95cf6096a316bbd275af175da0261811cd574e9f99d9e616098c4e26f6042b8b98b96d24dffd8e75b83d6568ed2ae816d51f4ddf46a6bf98adb73ea42970e7ab66cecc7df2abc251174d0ec0d0a1e11800c9c5ac5099ac5bd728956cbb46b9373793a99adf445338edfc0ca1429c5765975bef22a1434de408289350b369aa37c9680bab9/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep11.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep11&img=https://media.themoviedb.org/t/p/original/a6KSSuzIzyR8WnTC0sKIG6WKtTx.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/c9b63b200f43177fcc3258b95cf6096a316bbd275af175da0261811cd574e9f99d9e616098c4e26f6042b8b98b96d24dffd8e75b83d6568ed2ae816d51f4ddf46a6bf98adb73ea42970e7ab66cecc7df2abc251174d0ec0d0a1e11800c9c5ac5099ac5bd728956cbb46b9373793a99adf445338edfc0ca1429c5765975bef22a1434de408289350b369aa37c9680bab9/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep11.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep11&img=https://media.themoviedb.org/t/p/original/a6KSSuzIzyR8WnTC0sKIG6WKtTx.jpg",
});
mapRedirect(["all-of-us-are-dead-s1-ep12"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 12 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/1ff30ac89f34a965ee88010ae9c8433684a6cdc839240babd8bad25511cca402ee9725625f71d15caaf9d9e9912f9fd2b6271e44d2f66e037a6c2cc2bae954f42e253c8b82aaa865a0824586e0fd37f283b3ec0affb9dd82fa74ab8b698325d9100356cb00ff3980e00ae397e60b9dcbb1c9f2064492aebaaf4cd0b19cf0bd3da98113cd59e53ab11417e2bcf32fd278/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep12.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep12&img=https://media.themoviedb.org/t/p/original/a6KSSuzIzyR8WnTC0sKIG6WKtTx.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/1ff30ac89f34a965ee88010ae9c8433684a6cdc839240babd8bad25511cca402ee9725625f71d15caaf9d9e9912f9fd2b6271e44d2f66e037a6c2cc2bae954f42e253c8b82aaa865a0824586e0fd37f283b3ec0affb9dd82fa74ab8b698325d9100356cb00ff3980e00ae397e60b9dcbb1c9f2064492aebaaf4cd0b19cf0bd3da98113cd59e53ab11417e2bcf32fd278/playlist.m3u8&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep12.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep12&img=https://media.themoviedb.org/t/p/original/a6KSSuzIzyR8WnTC0sKIG6WKtTx.jpg",
});

//All of us are dead Hindi
mapRedirect(["all-of-us-are-dead-hindi-s1-ep1"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 1 Hindi Dubbed",
    video: "series.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E01.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep1.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep1&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
    video2: "series2.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E01.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep1.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep1&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
});
mapRedirect(["all-of-us-are-dead-hindi-s1-ep2"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 2 Hindi Dubbed",
    video: "series.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E02.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep2.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep2&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
    video2: "series2.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E02.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep2.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep2&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
});
mapRedirect(["all-of-us-are-dead-hindi-s1-ep3"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 3 Hindi Dubbed",
    video: "series.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E03.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep3.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep3&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
    video2: "series2.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E03.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep3.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep3&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
});
mapRedirect(["all-of-us-are-dead-hindi-s1-ep4"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 4 Hindi Dubbed",
    video: "series.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E04.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep4.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep4&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
    video2: "series2.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E04.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep4.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep4&img=https://media.themoviedb.org/t/p/original/jZAtLKNZbQZZLm9OLcY9rdZZV5F.jpg",
});
mapRedirect(["all-of-us-are-dead-hindi-s1-ep5"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 5 Hindi Dubbed",
    video: "series.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E05.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep5.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep5&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
    video2: "series2.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E05.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep5.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep5&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
});
mapRedirect(["all-of-us-are-dead-hindi-s1-ep6"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 6 Hindi Dubbed",
    video: "series.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E06.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep6.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep6&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
    video2: "series2.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E06.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep6.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep6&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
});
mapRedirect(["all-of-us-are-dead-hindi-s1-ep7"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 7 Hindi Dubbed",
    video: "series.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E07.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep7.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep7&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
    video2: "series2.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E07.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep7.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep7&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
});
mapRedirect(["all-of-us-are-dead-hindi-s1-ep8"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 8 Hindi Dubbed",
    video: "series.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E08.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep8.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep8&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
    video2: "series2.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E08.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep8.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep8&img=https://media.themoviedb.org/t/p/original/127aRvlbSstuJRDHvDuhAdqqSAq.jpg",
});
mapRedirect(["all-of-us-are-dead-hindi-s1-ep9"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 9 Hindi Dubbed",
    video: "series.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E09.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep9.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep9&img=https://media.themoviedb.org/t/p/original/shdj51xhg74pl6ENL7YYeqmWFIG.jpg",
    video2: "series2.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E09.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep9.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep9&img=https://media.themoviedb.org/t/p/original/shdj51xhg74pl6ENL7YYeqmWFIG.jpg",
});
mapRedirect(["all-of-us-are-dead-hindi-s1-ep10"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 10 Hindi Dubbed",
    video: "series.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E10.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep10.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep10&img=https://media.themoviedb.org/t/p/original/shdj51xhg74pl6ENL7YYeqmWFIG.jpg",
    video2: "series2.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E10.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep10.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep10&img=https://media.themoviedb.org/t/p/original/shdj51xhg74pl6ENL7YYeqmWFIG.jpg",
});
mapRedirect(["all-of-us-are-dead-hindi-s1-ep11"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 11 Hindi Dubbed",
    video: "series.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E11.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep11.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep11&img=https://media.themoviedb.org/t/p/original/a6KSSuzIzyR8WnTC0sKIG6WKtTx.jpg",
    video2: "series2.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E11.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep11.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep11&img=https://media.themoviedb.org/t/p/original/a6KSSuzIzyR8WnTC0sKIG6WKtTx.jpg",
});
mapRedirect(["all-of-us-are-dead-hindi-s1-ep12"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
    title: "Watch All of us are dead Season 1 Episode 12 Hindi Dubbed",
    video: "series.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E12.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep12.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep12&img=https://media.themoviedb.org/t/p/original/a6KSSuzIzyR8WnTC0sKIG6WKtTx.jpg",
    video2: "series2.html?source=https://archive.org/download/allof-us-are-dead.-s01.-1080p-hevc/World4ufree1.me_AllofUsAreDead.S01.E12.1080pHEVC.mp4&subcode=en&substitleurl=substitles/series/all-of-us-are-dead/all-of-us-are-dead-s1-ep12.srt&title-1=All%20of%20us%20are%20dead%20S1%20Ep12&img=https://media.themoviedb.org/t/p/original/a6KSSuzIzyR8WnTC0sKIG6WKtTx.jpg",
});

//Game Of Thrones Season 01
mapRedirect(["game-of-thrones-s1-ep1"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 01 Episode 1",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/b79b38db69b34ffeecb2b007cc76d4fc980e861c82640a4217cffe143de54008643be5a5f7e0fff94ed0dd35a35b893682c9ff31328466e7256000aa80e40f88100e1dfcf77d0874a3c898cfc284986d1c467e6fa44536aea836c8c08aad392fa7b590b7e983bb11cdd37fca11bb86b0c124e1bc74d2032da7087f609ef9e23dfa0764860585e732ccbe7452e8ed7bf1/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP01.srt&title-1=GOT%20S01%20EP01&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/b79b38db69b34ffeecb2b007cc76d4fc980e861c82640a4217cffe143de54008643be5a5f7e0fff94ed0dd35a35b893682c9ff31328466e7256000aa80e40f88100e1dfcf77d0874a3c898cfc284986d1c467e6fa44536aea836c8c08aad392fa7b590b7e983bb11cdd37fca11bb86b0c124e1bc74d2032da7087f609ef9e23dfa0764860585e732ccbe7452e8ed7bf1/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP01.srt&title-1=GOT%20S01%20EP01&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=1399&season=1&episode=1&ds_lang=en",
});
mapRedirect(["game-of-thrones-s1-ep2"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 01 Episode 2",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/cf7ff53817fcc30972ae6f644f8aa95b859dbe19a4fd217f6869735a29b22614accd86131861460cf722836bef3e2eac2521f7b29b1bce2c1b13b553ed5d0352fe41f9d2cba0b824c20b5724ffbdce74cd1f8a8a9217c951f23c3fbf55d6523c932c675e0e3c838516d77fdddb0453b7908023c970f98e8f56c5c148741b8528536bb4883140edcad13d398085c38833/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP02.srt&title-1=GOT%20S01%20EP02&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/cf7ff53817fcc30972ae6f644f8aa95b859dbe19a4fd217f6869735a29b22614accd86131861460cf722836bef3e2eac2521f7b29b1bce2c1b13b553ed5d0352fe41f9d2cba0b824c20b5724ffbdce74cd1f8a8a9217c951f23c3fbf55d6523c932c675e0e3c838516d77fdddb0453b7908023c970f98e8f56c5c148741b8528536bb4883140edcad13d398085c38833/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP02.srt&title-1=GOT%20S01%20EP02&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=1399&season=1&episode=2&ds_lang=en",
});
mapRedirect(["game-of-thrones-s1-ep3"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 01 Episode 3",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=1399&season=1&episode=3&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/50525add85f913e574f988aec57df5109edbc5f09d6867e37ea548a54fe5a9866ff0cc712cad7b400b7ca9b9b87a8bcc486c6930593e26a43c4038280c387a2fd45de458b0264c313e756cb3a2690329f9d9bae12cd372171cc79dcfd7a3318d3e4375f8f6be1ee8b23c3ab63d02528d98e111503614109d5993d4f6ea9e573a9403672bfb2db0b7f24a29c1814e4292/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP03.srt&title-1=GOT%20S01%20EP03&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/50525add85f913e574f988aec57df5109edbc5f09d6867e37ea548a54fe5a9866ff0cc712cad7b400b7ca9b9b87a8bcc486c6930593e26a43c4038280c387a2fd45de458b0264c313e756cb3a2690329f9d9bae12cd372171cc79dcfd7a3318d3e4375f8f6be1ee8b23c3ab63d02528d98e111503614109d5993d4f6ea9e573a9403672bfb2db0b7f24a29c1814e4292/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP03.srt&title-1=GOT%20S01%20EP03&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
});
mapRedirect(["game-of-thrones-s1-ep4"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 01 Episode 4",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=1399&season=1&episode=4&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/6f44963c72f9eeef36b03d3dfb4a401106734bd65444db7889852bd1cfca826f00e717228a6d786d29f85c751f24fe8532867e128193f6068f514b64ae53d07405aa07db79d281780f16f9da5a25592408cbc45543a86476cb9b3f8004e8e3f4915d942c3a5b9c79f5c01759f2e6ab1c8e3d742570f40796d4e80e794a9a7bd405de3fb751afa75f2ab8fd178f533a95/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP04.srt&title-1=GOT%20S01%20EP04&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/6f44963c72f9eeef36b03d3dfb4a401106734bd65444db7889852bd1cfca826f00e717228a6d786d29f85c751f24fe8532867e128193f6068f514b64ae53d07405aa07db79d281780f16f9da5a25592408cbc45543a86476cb9b3f8004e8e3f4915d942c3a5b9c79f5c01759f2e6ab1c8e3d742570f40796d4e80e794a9a7bd405de3fb751afa75f2ab8fd178f533a95/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP04.srt&title-1=GOT%20S01%20EP04&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
});
mapRedirect(["game-of-thrones-s1-ep5"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 01 Episode 5",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=1399&season=1&episode=5&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/8caa0ef4052928234150ab4c5be709dbc5e9cac55da8638ac75e910da5e0d8b02fb13005660a157e7029ba2523fda73faab4b5d880fba7ed0a284e4228927ebca0d97dfacd0ada436a2b496c3f0bcc979b86a3919c34beed0b5995d52fa6bd49392d005d54dddc5e45c85cf0e2c7befc3723bcdd669ccd38f684a230bfbd68fe70cae89d181f627ae60800670fa4c6ff/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP05.srt&title-1=GOT%20S01%20EP05&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/8caa0ef4052928234150ab4c5be709dbc5e9cac55da8638ac75e910da5e0d8b02fb13005660a157e7029ba2523fda73faab4b5d880fba7ed0a284e4228927ebca0d97dfacd0ada436a2b496c3f0bcc979b86a3919c34beed0b5995d52fa6bd49392d005d54dddc5e45c85cf0e2c7befc3723bcdd669ccd38f684a230bfbd68fe70cae89d181f627ae60800670fa4c6ff/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP05.srt&title-1=GOT%20S01%20EP05&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
});
mapRedirect(["game-of-thrones-s1-ep6"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 01 Episode 6",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=1399&season=1&episode=6&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/ec09cec9a64a0f8735f9454332024c2141d7c6c583433bb03ace9cc48a0b338d407f709f9da6c3c9ba7f7407b5adbdd2d66fc1f11533fba5004a8887a5db69772cf3607c9836e6a216975adc5ae840b87990cf7aeb0e9c2032fbc629c043cc151e0787df84edecc0edb9a7d7d952268e8f432263e6abbbe73bddcd19708ac13260fdddc05e1a330b09c0198315e1de85/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP06.srt&title-1=GOT%20S01%20EP06&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/ec09cec9a64a0f8735f9454332024c2141d7c6c583433bb03ace9cc48a0b338d407f709f9da6c3c9ba7f7407b5adbdd2d66fc1f11533fba5004a8887a5db69772cf3607c9836e6a216975adc5ae840b87990cf7aeb0e9c2032fbc629c043cc151e0787df84edecc0edb9a7d7d952268e8f432263e6abbbe73bddcd19708ac13260fdddc05e1a330b09c0198315e1de85/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP06.srt&title-1=GOT%20S01%20EP06&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
});
mapRedirect(["game-of-thrones-s1-ep7"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 01 Episode 7",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=1399&season=1&episode=7&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/3c52e3004a1ca95d00d14f099fa3478db9c23f698987a8df2b3619639332b4f5ae456df987c8ac5311f9428063249b94fe7523d48e5ed436b2378a061d28414933bdac708b3a1c01b842539f277addcc31363dc01078fd8afb14dc8982aec2ba2944afb6741c21109b7aade9dea4b2e7a22b99b4bc19c81f7beacdb37734ff776b0f34dbd887235f2fb61c85a224e04c/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP07.srt&title-1=GOT%20S01%20EP07&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/3c52e3004a1ca95d00d14f099fa3478db9c23f698987a8df2b3619639332b4f5ae456df987c8ac5311f9428063249b94fe7523d48e5ed436b2378a061d28414933bdac708b3a1c01b842539f277addcc31363dc01078fd8afb14dc8982aec2ba2944afb6741c21109b7aade9dea4b2e7a22b99b4bc19c81f7beacdb37734ff776b0f34dbd887235f2fb61c85a224e04c/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP07.srt&title-1=GOT%20S01%20EP07&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
});
mapRedirect(["game-of-thrones-s1-ep8"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 01 Episode 8",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=1399&season=1&episode=8&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/74fe699d9efe993ce3d7e6a40c02537fd40905f8d8ae014fc8f095c5462edd99cc6a67fa689d6163a5f50841b8c23add60fa6ea85e512be22ce802ca4ffa96879a3a9960df536025277b5f8cd7956695a61848ba248910b9ddc7c70ff2b1e826a950285152e6dfe3b10270d7037d2689dd329dcc348ef52b96da6bd0d150c0523c7d149394242e68c59fee5d39a258f5/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP08.srt&title-1=GOT%20S01%20EP08&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/74fe699d9efe993ce3d7e6a40c02537fd40905f8d8ae014fc8f095c5462edd99cc6a67fa689d6163a5f50841b8c23add60fa6ea85e512be22ce802ca4ffa96879a3a9960df536025277b5f8cd7956695a61848ba248910b9ddc7c70ff2b1e826a950285152e6dfe3b10270d7037d2689dd329dcc348ef52b96da6bd0d150c0523c7d149394242e68c59fee5d39a258f5/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP08.srt&title-1=GOT%20S01%20EP08&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
});
mapRedirect(["game-of-thrones-s1-ep9"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 01 Episode 9",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=1399&season=1&episode=9&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/7171790cdd4586ab9a6c8615d75bf5fd1f220adff5ceabdaeb2e19109978b48c17a75d05b37212632974d26dc3a73347d2c61ad20ebdaf96d41326a7b918cedb845858a9d707b94fc6d73ae783605f083a61ead6723db95d1123314466e48e2de16dc2b7711478f36c06a722aec7a81cc06a2fe7c603d00ff3ddbdc70380f7f17edfd9083c04b05a2a92067cf7770a59/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP09.srt&title-1=GOT%20S01%20EP09&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/7171790cdd4586ab9a6c8615d75bf5fd1f220adff5ceabdaeb2e19109978b48c17a75d05b37212632974d26dc3a73347d2c61ad20ebdaf96d41326a7b918cedb845858a9d707b94fc6d73ae783605f083a61ead6723db95d1123314466e48e2de16dc2b7711478f36c06a722aec7a81cc06a2fe7c603d00ff3ddbdc70380f7f17edfd9083c04b05a2a92067cf7770a59/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP09.srt&title-1=GOT%20S01%20EP09&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
});
mapRedirect(["game-of-thrones-s1-ep10"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 01 Episode 10",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=1399&season=1&episode=10&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/2815de86af4745739851b78da337ddcbc6a16ced2cb1044fedd0a6de1671d9a8d1ec3d93ed1a37d09c1bf6428c82d1ff2e4681c9849416479e35fb4c810463715f9c115065005dfe751975ae64d2b84fdc867472226254d5c06ee89c8f13043512ed29c12ef1833975e2a93f4c69a60468173df387a3bb4f8dfeea25761a6ad76d18e3a818fca91bb29d08d4e6bdade3/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP10.srt&title-1=GOT%20S01%20EP10&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/2815de86af4745739851b78da337ddcbc6a16ced2cb1044fedd0a6de1671d9a8d1ec3d93ed1a37d09c1bf6428c82d1ff2e4681c9849416479e35fb4c810463715f9c115065005dfe751975ae64d2b84fdc867472226254d5c06ee89c8f13043512ed29c12ef1833975e2a93f4c69a60468173df387a3bb4f8dfeea25761a6ad76d18e3a818fca91bb29d08d4e6bdade3/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S01/GOT.S01.EP10.srt&title-1=GOT%20S01%20EP10&img=https://store-images.s-microsoft.com/image/apps.47513.67375589377632987.ff61f16b-6c5e-4812-9b88-74a483fce64f.5e32396f-6a67-49c7-bb35-604784445391?mode=scale&q=90&h=1080&w=1920&format=jpg",
});

//Game Of Thrones Season 02
mapRedirect(["game-of-thrones-s2-ep1"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 02 Episode 1",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/ddb7d451610457f9cfdf3267ed41ea81f3f2b40ec5bf25d1af255ad47c365ee4c64e3d88da64944c94d6656ee8d21c20b0d7c393afcb55e524f51e98270a6001500eed47de44bd11457a18401acda5747cd706b48ac2b4fc1b52df7f158cfb02cc2f3f34f74282ecb25d3cdf5b7d245c78e4549480a78fb862e553e0b9ec039910d79fcf6624aaee503a3b7cc89bc09c/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP01.srt&title-1=GOT%20S02%20EP01&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/ddb7d451610457f9cfdf3267ed41ea81f3f2b40ec5bf25d1af255ad47c365ee4c64e3d88da64944c94d6656ee8d21c20b0d7c393afcb55e524f51e98270a6001500eed47de44bd11457a18401acda5747cd706b48ac2b4fc1b52df7f158cfb02cc2f3f34f74282ecb25d3cdf5b7d245c78e4549480a78fb862e553e0b9ec039910d79fcf6624aaee503a3b7cc89bc09c/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP01.srt&title-1=GOT%20S02%20EP01&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
});
mapRedirect(["game-of-thrones-s2-ep2"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 02 Episode 2",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/e5f55cd3e516014ad9fb17483834ab81d830f8c8e49f5514053d424895500fb965ca0943a742b7ae955ecf0d9a3045761b603c653e79f9a5790b1b8fd04d49b4bde11d1e2ee7306e6a2a08d6cccea02ada8996b7dd39e240b5ca94c1623d0afe6c660df4e75c8f0b906e6dbc2ca600b6b4f13f011a2a26a6b17696c80aea9f491cee458b16a69e2bf62f73f93419ca1d/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP02.srt&title-1=GOT%20S02%20EP02&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/e5f55cd3e516014ad9fb17483834ab81d830f8c8e49f5514053d424895500fb965ca0943a742b7ae955ecf0d9a3045761b603c653e79f9a5790b1b8fd04d49b4bde11d1e2ee7306e6a2a08d6cccea02ada8996b7dd39e240b5ca94c1623d0afe6c660df4e75c8f0b906e6dbc2ca600b6b4f13f011a2a26a6b17696c80aea9f491cee458b16a69e2bf62f73f93419ca1d/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP02.srt&title-1=GOT%20S02%20EP02&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
});
mapRedirect(["game-of-thrones-s2-ep3"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 02 Episode 3",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/097975364d732e3376df5bc3e60b8c036863c0a0a9b265f836d94c81724bdd56077353b89a2621d9e516fc1b939c1180fbf6f456fbfaea032885c18f80f3fcbdf88aa5def5ccbc8dcab651dbb47d87191594409ad80a49785c3478f443b6aeadacab0ec84c542c6f4dc543f664d397061d436250d0d12eb22250f508af66247f496b71844267f97b53f650d9e61c26d7/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP03.srt&title-1=GOT%20S02%20EP03&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/097975364d732e3376df5bc3e60b8c036863c0a0a9b265f836d94c81724bdd56077353b89a2621d9e516fc1b939c1180fbf6f456fbfaea032885c18f80f3fcbdf88aa5def5ccbc8dcab651dbb47d87191594409ad80a49785c3478f443b6aeadacab0ec84c542c6f4dc543f664d397061d436250d0d12eb22250f508af66247f496b71844267f97b53f650d9e61c26d7/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP03.srt&title-1=GOT%20S02%20EP03&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
});
mapRedirect(["game-of-thrones-s2-ep4"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 02 Episode 4",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/c382e027da9a4632d1f7381369026c3b8c386a07155ae4adb5f2baeb0ad8ed86d1bbe9a251829e6530abcf7dff8ef849b4a7ca168571eb3a4e80319701e316808e59b92a047a14b3f0c387794084758d22099c276e30befbd5421cd6fa79dce62bdd733b0e370327a75ddf82859c1d0e478758443a5bc29020b4c992fc4834f85165c41d91b6379547d8e5c6b8e9de1f/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP04.srt&title-1=GOT%20S02%20EP04&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/c382e027da9a4632d1f7381369026c3b8c386a07155ae4adb5f2baeb0ad8ed86d1bbe9a251829e6530abcf7dff8ef849b4a7ca168571eb3a4e80319701e316808e59b92a047a14b3f0c387794084758d22099c276e30befbd5421cd6fa79dce62bdd733b0e370327a75ddf82859c1d0e478758443a5bc29020b4c992fc4834f85165c41d91b6379547d8e5c6b8e9de1f/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP04.srt&title-1=GOT%20S02%20EP04&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
});
mapRedirect(["game-of-thrones-s2-ep5"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 02 Episode 5",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/33808013b19dfde3ee5d6302cde14abfc5f94acb2de5e2f5a1a07aa87b11201697dbf845abf7a6c6b36584fdf446f568f9d69a8109283516a9cfcd330ad9e152c9a7dff7c8ed87ecf6183b5494679c8e0521b9a530795a3e558ab2909f0e22eb846d8373d06bdeda7f433e9cb6680aac2aabc04fc72805d6de9636e51ea631415793a1f7a01aec5869b969f853b5f040/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP05.srt&title-1=GOT%20S02%20EP05&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/33808013b19dfde3ee5d6302cde14abfc5f94acb2de5e2f5a1a07aa87b11201697dbf845abf7a6c6b36584fdf446f568f9d69a8109283516a9cfcd330ad9e152c9a7dff7c8ed87ecf6183b5494679c8e0521b9a530795a3e558ab2909f0e22eb846d8373d06bdeda7f433e9cb6680aac2aabc04fc72805d6de9636e51ea631415793a1f7a01aec5869b969f853b5f040/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP05.srt&title-1=GOT%20S02%20EP05&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
});
mapRedirect(["game-of-thrones-s2-ep6"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 02 Episode 6",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/40cebbef78bab58ada5584829b8c5600b6fee1f625da7610b818ddf725f5881003b351a71f34adcffe7c926dbde97a9f3f03834b486003d4ebe3512680dc10802dba73930d9929807843dc1c31230eefbc30d694bc8428bc35e704a79097897c3139982524da2f9cbd00c10d2d46bd00298c9e765a29d32ff9ce79b5b823a2cbc55facd5d46af3936dffaac796c5a2aa/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP06.srt&title-1=GOT%20S02%20EP06&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/40cebbef78bab58ada5584829b8c5600b6fee1f625da7610b818ddf725f5881003b351a71f34adcffe7c926dbde97a9f3f03834b486003d4ebe3512680dc10802dba73930d9929807843dc1c31230eefbc30d694bc8428bc35e704a79097897c3139982524da2f9cbd00c10d2d46bd00298c9e765a29d32ff9ce79b5b823a2cbc55facd5d46af3936dffaac796c5a2aa/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP06.srt&title-1=GOT%20S02%20EP06&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
});
mapRedirect(["game-of-thrones-s2-ep7"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 02 Episode 7",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/75ca853ba9c1ff897c388848d6a4e2c39bd7e22b1cbc000d909714e988578be51bfbcf8f584fdafdffa22d187f5444c3a34424eb4c3f6cd305d1184535cd177707fd885f801cf257975a9f359cc524434e1cadadab30dee4d13a98bcbb9406eaa0eea93d313af0ec48001d155d7875069462b8170b502d799786b477dc6b52155083db4e79e515c12e51268a5b2eb912/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP07.srt&title-1=GOT%20S02%20EP07&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/75ca853ba9c1ff897c388848d6a4e2c39bd7e22b1cbc000d909714e988578be51bfbcf8f584fdafdffa22d187f5444c3a34424eb4c3f6cd305d1184535cd177707fd885f801cf257975a9f359cc524434e1cadadab30dee4d13a98bcbb9406eaa0eea93d313af0ec48001d155d7875069462b8170b502d799786b477dc6b52155083db4e79e515c12e51268a5b2eb912/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP07.srt&title-1=GOT%20S02%20EP07&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
});
mapRedirect(["game-of-thrones-s2-ep8"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 02 Episode 8",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/d953401b4ee323beaa12bc18bba7cb8bcdd0c44d723f34a1bc9b3908b43249083b0bddc0ff1f800740e80c657ccb62df0d8bc0f6d8debc5c595fd74fea64a1a34612188f4186d176f305d2eac7a968a0cce40506a1a63af24d3b3d4ee6a6636f55379d3168af767679feda97dd13e1f33a7483fa2b508a74d81299925d726299a69458bb581c3155621009689d48be98/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP08.srt&title-1=GOT%20S02%20EP08&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/d953401b4ee323beaa12bc18bba7cb8bcdd0c44d723f34a1bc9b3908b43249083b0bddc0ff1f800740e80c657ccb62df0d8bc0f6d8debc5c595fd74fea64a1a34612188f4186d176f305d2eac7a968a0cce40506a1a63af24d3b3d4ee6a6636f55379d3168af767679feda97dd13e1f33a7483fa2b508a74d81299925d726299a69458bb581c3155621009689d48be98/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP08.srt&title-1=GOT%20S02%20EP08&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
});
mapRedirect(["game-of-thrones-s2-ep9"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 02 Episode 9",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/690cd892c1f41b4839c92feff1605bdcd1a058e7846c42fc788233c564b76ac80c56bc591a5a35479dc35071854a8b467c390aae5e9a796b7e4d910eab69e548125bd44c771a1ed48565415121965952df2b79a282e66c5bb480a0098a0101b4156783f951dc73779d6e333a17cd178deec493dd0a7f1f78e3aeb3bb3bd654a5e827715028b8cb54ae59bf8f247453f3/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP09.srt&title-1=GOT%20S02%20EP09&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/690cd892c1f41b4839c92feff1605bdcd1a058e7846c42fc788233c564b76ac80c56bc591a5a35479dc35071854a8b467c390aae5e9a796b7e4d910eab69e548125bd44c771a1ed48565415121965952df2b79a282e66c5bb480a0098a0101b4156783f951dc73779d6e333a17cd178deec493dd0a7f1f78e3aeb3bb3bd654a5e827715028b8cb54ae59bf8f247453f3/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP09.srt&title-1=GOT%20S02%20EP09&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
});
mapRedirect(["game-of-thrones-s2-ep10"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 02 Episode 10",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/c61862e931d9ae58e6fa49353bf0bf3e723b63f91d9e8e00151bf1c66add0c87b4b04e0036cd8c7eecdb064c46b0f0d447c2df80dc316ca6a0619d83ebb5904a3a1e72c9859ac1dd0451a938bc487d23f5593183f77de186a57032fa4a9a92d0274940e8bb92f19adab3171278199ec478513c6bcd4929bc67c53c3f29b9f571bb89d8891e3c94ed622b4c8f53616855/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP10.srt&title-1=GOT%20S02%20EP10&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/c61862e931d9ae58e6fa49353bf0bf3e723b63f91d9e8e00151bf1c66add0c87b4b04e0036cd8c7eecdb064c46b0f0d447c2df80dc316ca6a0619d83ebb5904a3a1e72c9859ac1dd0451a938bc487d23f5593183f77de186a57032fa4a9a92d0274940e8bb92f19adab3171278199ec478513c6bcd4929bc67c53c3f29b9f571bb89d8891e3c94ed622b4c8f53616855/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S02/GOT.S02.EP10.srt&title-1=GOT%20S02%20EP10&img=https://i1.wp.com/speculativechic.com/wp-content/uploads/2018/03/LargeThrones2.jpg?fit=1200%2C675",
});
//Game Of Thrones Season 03
mapRedirect(["game-of-thrones-s3-ep1"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 03 Episode 1",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/f9ec25d5cc8d6a43f5647cfb8dce035dc202810461103834c4d5e32f67002486a9d61f2bc1954a931bd334cfe59eb07ff1dd7c488307bcaa96fcff4d7929038caa923169c1c5030cf6bb1e392dc08034b63a75c9315f2102fa38235e7f7b415ca6586126294b20a200970e594921841e951fff6c5a17fed2c3d37c680bafdb6581272a922c3c72719c8f1e6ccabb3c56/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP01.srt&title-1=GOT%20S03%20EP01&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/f9ec25d5cc8d6a43f5647cfb8dce035dc202810461103834c4d5e32f67002486a9d61f2bc1954a931bd334cfe59eb07ff1dd7c488307bcaa96fcff4d7929038caa923169c1c5030cf6bb1e392dc08034b63a75c9315f2102fa38235e7f7b415ca6586126294b20a200970e594921841e951fff6c5a17fed2c3d37c680bafdb6581272a922c3c72719c8f1e6ccabb3c56/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP01.srt&title-1=GOT%20S03%20EP01&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
});
mapRedirect(["game-of-thrones-s3-ep2"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 03 Episode 2",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/7919f07af36e041e395da2b07b50105302ec57ba32bd4ef86423e599bab2abb2e4aaea00d8df8e8fc3dbaa83009028571b1a4c3db734bc1e94cbea0dc6a4dfbb0a921213fbb6975245c616a346f49d3828af4cfce138689f5b7928d0e56e6e32b93434d9a0dd83c7436bb7b40ad5210118c610a121642e56014f5ad58bc4d611977b3728834a257700976c34f097802c/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP02.srt&title-1=GOT%20S03%20EP02&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/7919f07af36e041e395da2b07b50105302ec57ba32bd4ef86423e599bab2abb2e4aaea00d8df8e8fc3dbaa83009028571b1a4c3db734bc1e94cbea0dc6a4dfbb0a921213fbb6975245c616a346f49d3828af4cfce138689f5b7928d0e56e6e32b93434d9a0dd83c7436bb7b40ad5210118c610a121642e56014f5ad58bc4d611977b3728834a257700976c34f097802c/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP02.srt&title-1=GOT%20S03%20EP02&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
});
mapRedirect(["game-of-thrones-s3-ep3"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 03 Episode 3",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/847f52fcf41fabe6f85331bead5413ffc12fafbef03858df0aa526a6409208ef14f4850f63048232e70fa8eb6e43110026fd620b09ab775d0b8fb258297212653726f90c4f048024844fc64de440a54669c6b1d9f92262324bfa362ab1e2aa7a2a5e658c06c9a5949cf2ee72ac7b113116c1b13e15aa1a5f3168a0275f79e4541f16c7d92bb3db54bae960f8cacc0155/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP03.srt&title-1=GOT%20S03%20EP03&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/847f52fcf41fabe6f85331bead5413ffc12fafbef03858df0aa526a6409208ef14f4850f63048232e70fa8eb6e43110026fd620b09ab775d0b8fb258297212653726f90c4f048024844fc64de440a54669c6b1d9f92262324bfa362ab1e2aa7a2a5e658c06c9a5949cf2ee72ac7b113116c1b13e15aa1a5f3168a0275f79e4541f16c7d92bb3db54bae960f8cacc0155/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP03.srt&title-1=GOT%20S03%20EP03&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
});
mapRedirect(["game-of-thrones-s3-ep4"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 03 Episode 4",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/c7ce3da4a84864466119232b36e715ae499ef0cea655237e278574198f55f6e9a22ad819770ef42d91488b7b54889ae55e9cb83c846c3af8f730e8483bb37a30d4091793892f05b91c5aa82231544740a19a3c29efb54a09abf8138d872155ee4265363cfae09db0b8b8b7e6cc6b31881124baca571e1ed099ae915c1bb2ba9d005d86fc156b27915ce4f304a59c5baf/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP04.srt&title-1=GOT%20S03%20EP04&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/c7ce3da4a84864466119232b36e715ae499ef0cea655237e278574198f55f6e9a22ad819770ef42d91488b7b54889ae55e9cb83c846c3af8f730e8483bb37a30d4091793892f05b91c5aa82231544740a19a3c29efb54a09abf8138d872155ee4265363cfae09db0b8b8b7e6cc6b31881124baca571e1ed099ae915c1bb2ba9d005d86fc156b27915ce4f304a59c5baf/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP04.srt&title-1=GOT%20S03%20EP04&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
});
mapRedirect(["game-of-thrones-s3-ep5"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 03 Episode 5",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/a885f748eaaf3838d8249995e7ebc0779025170e3672a5056f7a6b6a9515b444a8a79e36b33e3b46626ef0ed0f488f4f22fbf50bda76b4eb0704514fefa89be307287f82786bd4a613fda5ff96d0f0c15de4632c736197bf7b14f8579b07a5deb87f5e4bf63f66360876a756ef526a033ee806d041fee287d5f3568ea3eedc314464140c50537634211077f29cb6a21f/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP05.srt&title-1=GOT%20S03%20EP05&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/a885f748eaaf3838d8249995e7ebc0779025170e3672a5056f7a6b6a9515b444a8a79e36b33e3b46626ef0ed0f488f4f22fbf50bda76b4eb0704514fefa89be307287f82786bd4a613fda5ff96d0f0c15de4632c736197bf7b14f8579b07a5deb87f5e4bf63f66360876a756ef526a033ee806d041fee287d5f3568ea3eedc314464140c50537634211077f29cb6a21f/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP05.srt&title-1=GOT%20S03%20EP05&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
});
mapRedirect(["game-of-thrones-s3-ep6"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 03 Episode 6",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/8aaa4a2bd324ec060ed9f2a90539f781f33f5203bb36778f4574093ec3c257af2124bf10a10f795bcbd30d72c15e830f857da8859a4694439f2d7baadc4f78b61cf0d8f58de79d023ab1507c3d2d8988a29601399e044d63e1ae703e636df899ae9c0e66e61087c7f0becab88f260e3c945a6bf2dc22019524716f6bfbbcf0e591757923f8c7887decae4692160540cc/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP06.srt&title-1=GOT%20S03%20EP06&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/8aaa4a2bd324ec060ed9f2a90539f781f33f5203bb36778f4574093ec3c257af2124bf10a10f795bcbd30d72c15e830f857da8859a4694439f2d7baadc4f78b61cf0d8f58de79d023ab1507c3d2d8988a29601399e044d63e1ae703e636df899ae9c0e66e61087c7f0becab88f260e3c945a6bf2dc22019524716f6bfbbcf0e591757923f8c7887decae4692160540cc/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP06.srt&title-1=GOT%20S03%20EP06&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
});
mapRedirect(["game-of-thrones-s3-ep7"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 03 Episode 7",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/21aa28b1035916eee2fdd71d870ab993d1d4ec9b4d552932506f8a8afe4b8ed363029f374731b342bb20c38dd525c41b463cc03498d47e2c1baf74bed3c9624113f5b3a1b8d2ddc6b20e34eb71b1b93e1d1ca8e46a4ae1a1ec1c6c5a22817efb97b704d70060c0ef65192ca28bc43ce174f7eb73919714e9ab05bdd3cf315d4a6102e5bd460e8dfddbc3a82fff040783/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP07.srt&title-1=GOT%20S03%20EP07&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/21aa28b1035916eee2fdd71d870ab993d1d4ec9b4d552932506f8a8afe4b8ed363029f374731b342bb20c38dd525c41b463cc03498d47e2c1baf74bed3c9624113f5b3a1b8d2ddc6b20e34eb71b1b93e1d1ca8e46a4ae1a1ec1c6c5a22817efb97b704d70060c0ef65192ca28bc43ce174f7eb73919714e9ab05bdd3cf315d4a6102e5bd460e8dfddbc3a82fff040783/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP07.srt&title-1=GOT%20S03%20EP07&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
});
mapRedirect(["game-of-thrones-s3-ep8"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 03 Episode 8",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/87d95e487d28a82eda4042caf7ac830be9711b53b847c1f3ac2a42aa677637b812c1a6b7bdb0a44ec241a2568101a7ba73325dab11754640ceeb84595dd261d6ca3290f900a516d793e6dd02f72e13d3c89f5dd6f0bebff1131898989765cfdb78fbc91b1d192982f94bc5a76ab6af1e01e65710ac7ae619527018c1bd9b9bf4abe9241d7c6ac1f52ad07fbc5e25353e/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP08.srt&title-1=GOT%20S03%20EP08&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/87d95e487d28a82eda4042caf7ac830be9711b53b847c1f3ac2a42aa677637b812c1a6b7bdb0a44ec241a2568101a7ba73325dab11754640ceeb84595dd261d6ca3290f900a516d793e6dd02f72e13d3c89f5dd6f0bebff1131898989765cfdb78fbc91b1d192982f94bc5a76ab6af1e01e65710ac7ae619527018c1bd9b9bf4abe9241d7c6ac1f52ad07fbc5e25353e/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP08.srt&title-1=GOT%20S03%20EP08&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
});
mapRedirect(["game-of-thrones-s3-ep9"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 03 Episode 9",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/32dc4fd650221123b9eef226c211e66a952ad4f15bc9b3badfe24a4ad64bea02b69c44e71e07c1875dcf4f327a05ca4760206b809922a89a45bb295982f78cd6fa277d16d0b9c6378fbb23cb40a867f155a702a0f2b5603b1e5ad7b37805ac62005a9f09a2a6552661e24de6a72de70236d9c4adec976f461c073726c8e93f9d1bf2ca971b4cd7d6d9cb4d6dcac8d9da/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP09.srt&title-1=GOT%20S03%20EP09&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/32dc4fd650221123b9eef226c211e66a952ad4f15bc9b3badfe24a4ad64bea02b69c44e71e07c1875dcf4f327a05ca4760206b809922a89a45bb295982f78cd6fa277d16d0b9c6378fbb23cb40a867f155a702a0f2b5603b1e5ad7b37805ac62005a9f09a2a6552661e24de6a72de70236d9c4adec976f461c073726c8e93f9d1bf2ca971b4cd7d6d9cb4d6dcac8d9da/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP09.srt&title-1=GOT%20S03%20EP09&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
});
mapRedirect(["game-of-thrones-s3-ep10"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 03 Episode 10",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/5ebb7954c4c38926bc5d3ffc42820ff6a559baca5a6758b148f49d11b94c59ba8dcd4f0504fb55219fde30b85ef5739f6bd87cc16ca4d4996710a86a3709aeb51204cd9b70b72af9c8366ca1cbf30ff0684a05f1fb428b675c374d037ea6e5b3f700fe24c63cc606a1a7cd81c66aabfff813620f0f5ddc55400a8126543bd3a63e2e0d1be6eac8e5c69676769419eb2e/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP10.srt&title-1=GOT%20S03%20EP10&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/5ebb7954c4c38926bc5d3ffc42820ff6a559baca5a6758b148f49d11b94c59ba8dcd4f0504fb55219fde30b85ef5739f6bd87cc16ca4d4996710a86a3709aeb51204cd9b70b72af9c8366ca1cbf30ff0684a05f1fb428b675c374d037ea6e5b3f700fe24c63cc606a1a7cd81c66aabfff813620f0f5ddc55400a8126543bd3a63e2e0d1be6eac8e5c69676769419eb2e/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S03/GOT.S03.EP10.srt&title-1=GOT%20S03%20EP10&img=https://imageservice.sky.com/contentid/iYsxVQTYrUBMHZ3N6Wqffu/LAND_16_9-SEASON",
});
//Game Of Thrones Season 04
mapRedirect(["game-of-thrones-s4-ep1"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 04 Episode 1",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/e64378b8968a5ac1dad44fb6e3a3a912cacab1776555ef9bfc6ab862ef0550853e6c71ef13790a2974e706cf0c7aa755dcbc92600862774a97e41337739c3ba48163adcace0a86ed7275f0d124dc5def09063da78a77f26f62a6e4e8ff29d5026da7e07272edd1eeaf5a6090acd783d239eb78807e20ca48b3a0b161404573b1c0a29684d021c58a46483d3efcaab394/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP01.srt&title-1=GOT%20S04%20EP01&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/e64378b8968a5ac1dad44fb6e3a3a912cacab1776555ef9bfc6ab862ef0550853e6c71ef13790a2974e706cf0c7aa755dcbc92600862774a97e41337739c3ba48163adcace0a86ed7275f0d124dc5def09063da78a77f26f62a6e4e8ff29d5026da7e07272edd1eeaf5a6090acd783d239eb78807e20ca48b3a0b161404573b1c0a29684d021c58a46483d3efcaab394/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP01.srt&title-1=GOT%20S04%20EP01&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
});
mapRedirect(["game-of-thrones-s4-ep2"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 04 Episode 2",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/d8c9ccee106f8f60405b782c57f30673275b2e423ce2d82b4a510ffc6eb96f7e715223a781d7f2f6fcfb631c11cd70f185d9745fefc26bdf8e8d7282164bba3e06af30ea2e8e3fc034ad1ba6af54844dae166e5815daa85bacb60ab848ad2b9292da75aaa85a9385e745b52f617a8c6be43b57ead753d7680fbb02fe36dee640e5dc38d5ae09cb3f1e7bb5509627f063/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP02.srt&title-1=GOT%20S04%20EP02&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/d8c9ccee106f8f60405b782c57f30673275b2e423ce2d82b4a510ffc6eb96f7e715223a781d7f2f6fcfb631c11cd70f185d9745fefc26bdf8e8d7282164bba3e06af30ea2e8e3fc034ad1ba6af54844dae166e5815daa85bacb60ab848ad2b9292da75aaa85a9385e745b52f617a8c6be43b57ead753d7680fbb02fe36dee640e5dc38d5ae09cb3f1e7bb5509627f063/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP02.srt&title-1=GOT%20S04%20EP02&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
});
mapRedirect(["game-of-thrones-s4-ep3"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 04 Episode 3",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/4a6d674e2550ca4dc1217db45664b3d5c5399841977881099c14432893b762983197045342ed537fba17ffd0c47cf36e2adb02e2270ffa9d3b0a82117c48c8703bd48a1ed76f2e310f4bc6d2da2feeaf37012b046a7e21060914ba6e11f67de0f8d69ba06e4f7360b5aec0251f339abe4b3fef4c7f30c1487bcffe99c2458d6850071bcad4ffd5068fe000cab597a11b/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP03.srt&title-1=GOT%20S04%20EP03&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/4a6d674e2550ca4dc1217db45664b3d5c5399841977881099c14432893b762983197045342ed537fba17ffd0c47cf36e2adb02e2270ffa9d3b0a82117c48c8703bd48a1ed76f2e310f4bc6d2da2feeaf37012b046a7e21060914ba6e11f67de0f8d69ba06e4f7360b5aec0251f339abe4b3fef4c7f30c1487bcffe99c2458d6850071bcad4ffd5068fe000cab597a11b/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP03.srt&title-1=GOT%20S04%20EP03&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
});
mapRedirect(["game-of-thrones-s4-ep4"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 04 Episode 4",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/4d843e40983dcb084f5f966b291b406a7533f1528405ad9f069171040a74bc810a7bb266100945c3c8cab097a13faa4878f88ddbd0d09bf642287f086074d6e36af6baaf1f173f05353e0569291c24d502e29992b4d85e91ce5439d811e8031c5cadaa46def9ad57964fc48de0dcb6bc39b9f5bcd742d9f5f2547368dc4d6948564507d71a4ac9eebec7e9e61959b667/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP04.srt&title-1=GOT%20S04%20EP04&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/4d843e40983dcb084f5f966b291b406a7533f1528405ad9f069171040a74bc810a7bb266100945c3c8cab097a13faa4878f88ddbd0d09bf642287f086074d6e36af6baaf1f173f05353e0569291c24d502e29992b4d85e91ce5439d811e8031c5cadaa46def9ad57964fc48de0dcb6bc39b9f5bcd742d9f5f2547368dc4d6948564507d71a4ac9eebec7e9e61959b667/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP04.srt&title-1=GOT%20S04%20EP04&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
});
mapRedirect(["game-of-thrones-s4-ep5"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 04 Episode 5",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/cd2deef656f537c5d823f45e539f854cc51a6e63e2ee851c6e9d93fdcb5212ba630b24c32f48ec45f5fe80edd98cd6f9a4101b0ecc1c8adbd9e92d135cc478693598ff73e52969169eb4abe90155a20d02d66a7e553e39b7da5955e56940b3db8ced33d7ea204be35dd0b24fad1fd193bd67b2585a344c72b8c1fca868e6e85f26d8285f7d52cdfee727b9b0815793ff/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP05.srt&title-1=GOT%20S04%20EP05&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/cd2deef656f537c5d823f45e539f854cc51a6e63e2ee851c6e9d93fdcb5212ba630b24c32f48ec45f5fe80edd98cd6f9a4101b0ecc1c8adbd9e92d135cc478693598ff73e52969169eb4abe90155a20d02d66a7e553e39b7da5955e56940b3db8ced33d7ea204be35dd0b24fad1fd193bd67b2585a344c72b8c1fca868e6e85f26d8285f7d52cdfee727b9b0815793ff/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP05.srt&title-1=GOT%20S04%20EP05&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
});
mapRedirect(["game-of-thrones-s4-ep6"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 04 Episode 6",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/a089021a8bacb0752c90de862dd92169a04c1530b24e218dedad2406e76adef3ad013afdc1bc0fec39b808fee10a13a9c874cb018c06299c4ac4efd62b436f2829c74919a718846e9ddfea5152c2a83bb22745a3d5c97caf8d23c642976f4c149c74d6985a9382f911a6e176a5b1aa17da88719a1391fe4ca7e93a384235749d1d6f48739af2a9cf7f1831eef3c9983e/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP06.srt&title-1=GOT%20S04%20EP06&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/a089021a8bacb0752c90de862dd92169a04c1530b24e218dedad2406e76adef3ad013afdc1bc0fec39b808fee10a13a9c874cb018c06299c4ac4efd62b436f2829c74919a718846e9ddfea5152c2a83bb22745a3d5c97caf8d23c642976f4c149c74d6985a9382f911a6e176a5b1aa17da88719a1391fe4ca7e93a384235749d1d6f48739af2a9cf7f1831eef3c9983e/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP06.srt&title-1=GOT%20S04%20EP06&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
});
mapRedirect(["game-of-thrones-s4-ep7"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 04 Episode 7",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/2a3dc3c43184d6e8efe431dbac87a4befc322f2a3a2eb2979ddea670641be743f47542dc6853e9ba2a7488da5c0673c3d7ddc0f1e61c2f76cf287e87c2a37022ad5a26b1dcd3d05d6c7b97f0da9e0b4e31ffd109d92fbcad7d2eeb873064dead0ae9ac412c91f7bc3aa9f8dc17733c534285545c6bd7acd57f38c49cc4db131eaf6b51a690aa456333cd6e14dcc42675/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP07.srt&title-1=GOT%20S04%20EP07&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/2a3dc3c43184d6e8efe431dbac87a4befc322f2a3a2eb2979ddea670641be743f47542dc6853e9ba2a7488da5c0673c3d7ddc0f1e61c2f76cf287e87c2a37022ad5a26b1dcd3d05d6c7b97f0da9e0b4e31ffd109d92fbcad7d2eeb873064dead0ae9ac412c91f7bc3aa9f8dc17733c534285545c6bd7acd57f38c49cc4db131eaf6b51a690aa456333cd6e14dcc42675/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP07.srt&title-1=GOT%20S04%20EP07&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
});
mapRedirect(["game-of-thrones-s4-ep8"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 04 Episode 8",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/7520cdae4510d4db088abf9f4a9c385e425814f5838d9453cf9793a317615d998bb6c45dfa941012ea62023c3a52ebfddcedbcee5cf9377d2975e28fc345e160ff5eb0a9f97ffc5ea6ef32d64ca27d0e4752c8161e055533984e32296547c434c5db91843d2de6d6654f759b5b40f29e9c35e805c94a5ef97848d6142c53c75da1b707df0efe4290cc895376f99e0ca2/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP08.srt&title-1=GOT%20S04%20EP08&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/7520cdae4510d4db088abf9f4a9c385e425814f5838d9453cf9793a317615d998bb6c45dfa941012ea62023c3a52ebfddcedbcee5cf9377d2975e28fc345e160ff5eb0a9f97ffc5ea6ef32d64ca27d0e4752c8161e055533984e32296547c434c5db91843d2de6d6654f759b5b40f29e9c35e805c94a5ef97848d6142c53c75da1b707df0efe4290cc895376f99e0ca2/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP08.srt&title-1=GOT%20S04%20EP08&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
});
mapRedirect(["game-of-thrones-s4-ep9"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 04 Episode 9",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/f20557cff52a536cfb774a9706a709520c164ee20cb543778957d61fae7d4353308d72c1596b101932e83dd6a65167a469da16ac936e343182dabada1c37e14f42f2e16fb49c846e46693c660c4ed2fcaea09e220451528e5640add6db95abc3699bef214cb81d879cd1c847352be2b7bdf192aabbfe90e887965b686651b86e24777153409d0c4fc7a6b1d1f6d641c2/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP09.srt&title-1=GOT%20S04%20EP09&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/f20557cff52a536cfb774a9706a709520c164ee20cb543778957d61fae7d4353308d72c1596b101932e83dd6a65167a469da16ac936e343182dabada1c37e14f42f2e16fb49c846e46693c660c4ed2fcaea09e220451528e5640add6db95abc3699bef214cb81d879cd1c847352be2b7bdf192aabbfe90e887965b686651b86e24777153409d0c4fc7a6b1d1f6d641c2/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP09.srt&title-1=GOT%20S04%20EP09&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
});
mapRedirect(["game-of-thrones-s4-ep10"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 04 Episode 10",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/01fdddaca4bbce50dd79d19196303028b0958282bcfdfb2517040d863346e480fb5b7ada61affcefdcf1e8f34e1b86662faa3ef52ce046d6363c44b9d121d84b655751f51fae1466f535ac728c30db77f27026932ee7326be2bb6dbd3bf29b9e1d1e876cca82f7319fff4f390fa6e66567fac00b8c3679f9c17563ffea33d07292d6cca4a94f9ea52e793442c4da2afc/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP10.srt&title-1=GOT%20S04%20EP10&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/01fdddaca4bbce50dd79d19196303028b0958282bcfdfb2517040d863346e480fb5b7ada61affcefdcf1e8f34e1b86662faa3ef52ce046d6363c44b9d121d84b655751f51fae1466f535ac728c30db77f27026932ee7326be2bb6dbd3bf29b9e1d1e876cca82f7319fff4f390fa6e66567fac00b8c3679f9c17563ffea33d07292d6cca4a94f9ea52e793442c4da2afc/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S04/GOT.S04.EP10.srt&title-1=GOT%20S04%20EP10&img=https://m.media-amazon.com/images/S/pv-target-images/ef2049d368c0015ff0670470eb0158073ccd31e1b77b17ee39938ec5d8a0f636.jpg",
});
//Game Of Thrones Season 05
mapRedirect(["game-of-thrones-s5-ep1"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 05 Episode 1",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/432786fca30226b3618491d464580cc53c7466625529d453b67c0251c5eeeb53fcd65c666550d7c13be13b8e453c8352d7f8e1cb72dee0429034ee42c17ed86efd56fe13e2cd2d8e0f23235a5bd5fab5f3de4f5cc5bde48030a5195128826bb4d174a0043156f8fbb9ea5736244c8a0ac8230d95042761d5df6cddd0762148643483ffb5bd5515e859a036c5db237d23/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP01.srt&title-1=GOT%20S05%20EP01&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/432786fca30226b3618491d464580cc53c7466625529d453b67c0251c5eeeb53fcd65c666550d7c13be13b8e453c8352d7f8e1cb72dee0429034ee42c17ed86efd56fe13e2cd2d8e0f23235a5bd5fab5f3de4f5cc5bde48030a5195128826bb4d174a0043156f8fbb9ea5736244c8a0ac8230d95042761d5df6cddd0762148643483ffb5bd5515e859a036c5db237d23/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP01.srt&title-1=GOT%20S05%20EP01&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
});
mapRedirect(["game-of-thrones-s5-ep2"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 05 Episode 2",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/23c21537a513030c986c21b0e5a6933142f427bc375e14517a2e059f216d46d118097407995e66724ff98b74d1754791f4b3ada4724bf26567b1404216271b79afdd3d26873151288a14f3e5207a209892000f7b35457d0f257807b7605c02771090fcc2a7f928b70969db2f1d074c7888ed52192ae8751e360682b2cb5e6102187c7547b9d0bd6d0798b287b4678f02/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP02.srt&title-1=GOT%20S05%20EP02&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/23c21537a513030c986c21b0e5a6933142f427bc375e14517a2e059f216d46d118097407995e66724ff98b74d1754791f4b3ada4724bf26567b1404216271b79afdd3d26873151288a14f3e5207a209892000f7b35457d0f257807b7605c02771090fcc2a7f928b70969db2f1d074c7888ed52192ae8751e360682b2cb5e6102187c7547b9d0bd6d0798b287b4678f02/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP02.srt&title-1=GOT%20S05%20EP02&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
});
mapRedirect(["game-of-thrones-s5-ep3"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 05 Episode 3",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/840d5e617b175b507a0fa5d8a9e6f19c3e43481aaa792f6cee46d658da9fe55f6ac54e3509f1142b4d4a1db0dc49efba3d892646759d0635497dfc32322c0c90920b3e5acb22435ae195e2269a0abd31bcc4e8c0bcf36d7b801c0de4deaf7452785340c8d09e495177060f979d6bb5b410206d567ebe063769269c2a91f224c8284f74751a509d650ad629be4215d07d/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP03.srt&title-1=GOT%20S05%20EP03&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/840d5e617b175b507a0fa5d8a9e6f19c3e43481aaa792f6cee46d658da9fe55f6ac54e3509f1142b4d4a1db0dc49efba3d892646759d0635497dfc32322c0c90920b3e5acb22435ae195e2269a0abd31bcc4e8c0bcf36d7b801c0de4deaf7452785340c8d09e495177060f979d6bb5b410206d567ebe063769269c2a91f224c8284f74751a509d650ad629be4215d07d/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP03.srt&title-1=GOT%20S05%20EP03&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
});
mapRedirect(["game-of-thrones-s5-ep4"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 05 Episode 4",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/816e7ea147fb2b69e45e2361f2a81c5f3c7b130842fc5ea1893f1a1e508a602afbf5c20d0ba0ff1496649420857b0cdaf0538764ef8610690603e9964ab635001301a8ad681ab02063491e2163aeb923c1515e733064763a6ebe1aeedd40ee228868c329ea0472f601b0c2f061d17f179d9a2cb31699efb42c7690e62f80e98ad6d9c7c4a532a1d42b78facb12bafd62/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP04.srt&title-1=GOT%20S05%20EP04&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/816e7ea147fb2b69e45e2361f2a81c5f3c7b130842fc5ea1893f1a1e508a602afbf5c20d0ba0ff1496649420857b0cdaf0538764ef8610690603e9964ab635001301a8ad681ab02063491e2163aeb923c1515e733064763a6ebe1aeedd40ee228868c329ea0472f601b0c2f061d17f179d9a2cb31699efb42c7690e62f80e98ad6d9c7c4a532a1d42b78facb12bafd62/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP04.srt&title-1=GOT%20S05%20EP04&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
});
mapRedirect(["game-of-thrones-s5-ep5"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 05 Episode 5",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/4ba7cade833454913d1fd379a8236f19c7726059f21086d0adbfc8402676fff7f16bbfe4ccb52d492377d782fde8c161b708268649d1a540ba932da41d3f2033ddf254ddcdb36d61812c05fe7cfda9bc9f1d8ff82dc6c239673d8b15b32c25c6bf85abb0d8a90a482a36273a8544684f08cba15b86f23cd1749706198d62f4fff918f9981ace2cf6578b4d7d1e644538/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP05.srt&title-1=GOT%20S05%20EP05&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/4ba7cade833454913d1fd379a8236f19c7726059f21086d0adbfc8402676fff7f16bbfe4ccb52d492377d782fde8c161b708268649d1a540ba932da41d3f2033ddf254ddcdb36d61812c05fe7cfda9bc9f1d8ff82dc6c239673d8b15b32c25c6bf85abb0d8a90a482a36273a8544684f08cba15b86f23cd1749706198d62f4fff918f9981ace2cf6578b4d7d1e644538/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP05.srt&title-1=GOT%20S05%20EP05&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
});
mapRedirect(["game-of-thrones-s5-ep6"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 05 Episode 6",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/4e0f0ecd997b373f4e11751749127002bd8c2c5f9cc7b183ca3db63c36b7ec7dc34b5096f676e8ea38b00fbbce36a9c84e187661e7249f93cd55083f26abe295e04172fe3125b3cdade573b401f1667e6a0c69dd0db187898eb653a845acf78c4cb096de4d145b2e4f1867f7f3edeff12943bdde0714fe24de347f6cb3811f8dcb1bed4092d6f3bb76652d98487262f4/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP06.srt&title-1=GOT%20S05%20EP06&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/4e0f0ecd997b373f4e11751749127002bd8c2c5f9cc7b183ca3db63c36b7ec7dc34b5096f676e8ea38b00fbbce36a9c84e187661e7249f93cd55083f26abe295e04172fe3125b3cdade573b401f1667e6a0c69dd0db187898eb653a845acf78c4cb096de4d145b2e4f1867f7f3edeff12943bdde0714fe24de347f6cb3811f8dcb1bed4092d6f3bb76652d98487262f4/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP06.srt&title-1=GOT%20S05%20EP06&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
});
mapRedirect(["game-of-thrones-s5-ep7"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 05 Episode 7",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/f93685a517a0bc8133a03288d9a62e73ef3b05286918d05dc4f7d39336fdcb73250a567ca86585c474192977de4d2610d781a202a157d3b5a822cec7c0c6b7e69c1cb40a9a9bb6c51047c1abc1fe6d3b56a3f2be12e612c0b4afde4049c6539d5d8e9d58c60b250a32098e521cd768c7ae21354ce302b1e4d50071e47dfde875182682026a57215c379b9f77bf3a381a/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP07.srt&title-1=GOT%20S05%20EP07&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/f93685a517a0bc8133a03288d9a62e73ef3b05286918d05dc4f7d39336fdcb73250a567ca86585c474192977de4d2610d781a202a157d3b5a822cec7c0c6b7e69c1cb40a9a9bb6c51047c1abc1fe6d3b56a3f2be12e612c0b4afde4049c6539d5d8e9d58c60b250a32098e521cd768c7ae21354ce302b1e4d50071e47dfde875182682026a57215c379b9f77bf3a381a/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP07.srt&title-1=GOT%20S05%20EP07&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
});
mapRedirect(["game-of-thrones-s5-ep8"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 05 Episode 8",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/649ace38e4883594b1d6c16529e07dc30dfdae3ed2221382445bb55254c41dd84df17ae47b5a731f8b4b0707f6ac734b4ae93233ca420985b027de598626b8a25a9c0b12374f24f69af72acddb40cae7d29cdec356b21b00dfc3d305569c588c2ee2bbb4a17d25d1098cea30f12462e371fdd0879a658a1945c63804dd28685dc48f2235601781238f44c775ff47c9ce/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP08.srt&title-1=GOT%20S05%20EP08&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/649ace38e4883594b1d6c16529e07dc30dfdae3ed2221382445bb55254c41dd84df17ae47b5a731f8b4b0707f6ac734b4ae93233ca420985b027de598626b8a25a9c0b12374f24f69af72acddb40cae7d29cdec356b21b00dfc3d305569c588c2ee2bbb4a17d25d1098cea30f12462e371fdd0879a658a1945c63804dd28685dc48f2235601781238f44c775ff47c9ce/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP08.srt&title-1=GOT%20S05%20EP08&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
});
mapRedirect(["game-of-thrones-s5-ep9"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 05 Episode 9",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/5d0008a4b809b5052feeba26719086208773b3ad0dbaaa563b16395670f3b1a7c208801038664a2aa0cdc9d313de68df74ab9f4f3b5942992199b970a3e5d598de73bf5a4c034d0034e6fdc872a842251ad1d5eea0e28d2db63e909872833fc755fe48a21a4c56d6321178d4f10675c318b382a8e96171da51e74f2fa28a652c08a21c0e335f9526f5b535582f25e852/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP09.srt&title-1=GOT%20S05%20EP09&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/5d0008a4b809b5052feeba26719086208773b3ad0dbaaa563b16395670f3b1a7c208801038664a2aa0cdc9d313de68df74ab9f4f3b5942992199b970a3e5d598de73bf5a4c034d0034e6fdc872a842251ad1d5eea0e28d2db63e909872833fc755fe48a21a4c56d6321178d4f10675c318b382a8e96171da51e74f2fa28a652c08a21c0e335f9526f5b535582f25e852/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP09.srt&title-1=GOT%20S05%20EP09&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
});
mapRedirect(["game-of-thrones-s5-ep10"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 05 Episode 10",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/cad6287199b7f992a3d9d5ac2ba2ed3232dc02c9c807be8df09e4777583f141b7bb24f1e6a06da372df1d90f5000c3b8660459712d66eb42f172fb56828a24d7e79ab2c303343366806ce92f14dbc60848fedd7a3bfd9bc01b538b0b6d83ecdf1c2b058c09ebe0a2d4f5620b9b5f76739a9aedf3de181321eb2d33b91ce74b27b48ab5c74a4e28458c05a39b079b961d/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP10.srt&title-1=GOT%20S05%20EP10&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/cad6287199b7f992a3d9d5ac2ba2ed3232dc02c9c807be8df09e4777583f141b7bb24f1e6a06da372df1d90f5000c3b8660459712d66eb42f172fb56828a24d7e79ab2c303343366806ce92f14dbc60848fedd7a3bfd9bc01b538b0b6d83ecdf1c2b058c09ebe0a2d4f5620b9b5f76739a9aedf3de181321eb2d33b91ce74b27b48ab5c74a4e28458c05a39b079b961d/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S05/GOT.S05.EP10.srt&title-1=GOT%20S05%20EP10&img=https://assets1.ignimgs.com/2015/06/21/gtseunnamedjpg-a57820_160w.jpg?width=1280",
});


//Game Of Thrones Season 06
mapRedirect(["game-of-thrones-s6-ep1"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 06 Episode 1",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/15d68cfb2d46665617f18251aaa53ecd595bd0d0eac0eef7dd49da2a4df16c46b9f3fd62855890ca87f1070da9928e4666ffa8f2951b829c8c765f445e9babf87cb881709eed52bbf9ffe61e1a3928a80911bc3531fbfcdb228da18fddc570239653c9e392da58fe0bb663cfa193ec3affeec14bc098fa05149c03dd96a1d1c31094ec4a5fe255413a5837e9a8e1b3ec/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP01.srt&title-1=GOT%20S06%20EP01&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/15d68cfb2d46665617f18251aaa53ecd595bd0d0eac0eef7dd49da2a4df16c46b9f3fd62855890ca87f1070da9928e4666ffa8f2951b829c8c765f445e9babf87cb881709eed52bbf9ffe61e1a3928a80911bc3531fbfcdb228da18fddc570239653c9e392da58fe0bb663cfa193ec3affeec14bc098fa05149c03dd96a1d1c31094ec4a5fe255413a5837e9a8e1b3ec/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP01.srt&title-1=GOT%20S06%20EP01&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
});
mapRedirect(["game-of-thrones-s6-ep2"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 06 Episode 2",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/66206122bb8b933d4f72e5cb1aae8633187f5a207287c5cd6cd9070b57afb8df7d76d1a6f636dd7f51020e6f660cd323ab249c0ed3c37fc8ac9d375b9e30c58954f163ec6a8e60b94e2fa9990ab34b3f672bd0815472f08410489996de7ae9a0e122f2baf756828f9152b6fcaf98392fb8c1fad2872fa734dab3f9071dd732b497cfe3c0174a417757920ebf73d17d90/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP02.srt&title-1=GOT%20S06%20EP02&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/66206122bb8b933d4f72e5cb1aae8633187f5a207287c5cd6cd9070b57afb8df7d76d1a6f636dd7f51020e6f660cd323ab249c0ed3c37fc8ac9d375b9e30c58954f163ec6a8e60b94e2fa9990ab34b3f672bd0815472f08410489996de7ae9a0e122f2baf756828f9152b6fcaf98392fb8c1fad2872fa734dab3f9071dd732b497cfe3c0174a417757920ebf73d17d90/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP02.srt&title-1=GOT%20S06%20EP02&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
});
mapRedirect(["game-of-thrones-s6-ep3"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 06 Episode 3",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/dd94a58039f3b160ee780543f92094e3bd9027de6ab35c37d9e0eef3e83e876f8c0801fe77f32609667af180b74dc5b0789a2e75b9fbb3dce3e8aae450813307752a0e7e9ee01266e93aa8e0ba5d1597813a3a0ee8a4493f766404272284a0d240803f1e8c8884a859ddbd9fb4498b8cf86941fdc2c050805aa54988fc0ecee2ac18644e25273e0fea31d13bd9045ab6/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP03.srt&title-1=GOT%20S06%20EP03&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/dd94a58039f3b160ee780543f92094e3bd9027de6ab35c37d9e0eef3e83e876f8c0801fe77f32609667af180b74dc5b0789a2e75b9fbb3dce3e8aae450813307752a0e7e9ee01266e93aa8e0ba5d1597813a3a0ee8a4493f766404272284a0d240803f1e8c8884a859ddbd9fb4498b8cf86941fdc2c050805aa54988fc0ecee2ac18644e25273e0fea31d13bd9045ab6/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP03.srt&title-1=GOT%20S06%20EP03&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
});
mapRedirect(["game-of-thrones-s6-ep4"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 06 Episode 4",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/277bb6959b5d7bf446ddd6eeb91ff6b6e091c280245965531a266e8bb9e3fcbc24ce78c58211025c9f8b666a1ade50340573d99c19da1b9088a885836000e720d652c1a2e4834292d3fe4d8cd24888db788e3ec70a5f490ba1e814243ba6ae14a5429cce8195710e9a93e003400e56b21303179a678b7fb3cda9979d42bcefe09b2e429d42c2493672b05c301bebeb5e/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP04.srt&title-1=GOT%20S06%20EP04&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/277bb6959b5d7bf446ddd6eeb91ff6b6e091c280245965531a266e8bb9e3fcbc24ce78c58211025c9f8b666a1ade50340573d99c19da1b9088a885836000e720d652c1a2e4834292d3fe4d8cd24888db788e3ec70a5f490ba1e814243ba6ae14a5429cce8195710e9a93e003400e56b21303179a678b7fb3cda9979d42bcefe09b2e429d42c2493672b05c301bebeb5e/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP04.srt&title-1=GOT%20S06%20EP04&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
});
mapRedirect(["game-of-thrones-s6-ep5"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 06 Episode 5",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/5087c3490de48e0669ecc10099d6bbee06c7496f0eed2c76d5a3ba06ff0976a66dd839275b5860af70200625a869f7df1996c3c380a74dac0124ec7970d96ed61289e50d0fb92b0145620cd77abbdd871565783e7fd23d13085ab38781118efb6805e2548049796aaa6ac5f661698bec2a0bee7b79c0eb5133fff0f2b12dc80aab4f135ceb7554d8571c2d11a3ab30bc/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP05.srt&title-1=GOT%20S06%20EP05&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/5087c3490de48e0669ecc10099d6bbee06c7496f0eed2c76d5a3ba06ff0976a66dd839275b5860af70200625a869f7df1996c3c380a74dac0124ec7970d96ed61289e50d0fb92b0145620cd77abbdd871565783e7fd23d13085ab38781118efb6805e2548049796aaa6ac5f661698bec2a0bee7b79c0eb5133fff0f2b12dc80aab4f135ceb7554d8571c2d11a3ab30bc/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP05.srt&title-1=GOT%20S06%20EP05&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
});
mapRedirect(["game-of-thrones-s6-ep6"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 06 Episode 6",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/466ada3f008aa40fc7d5e20bab2ebac0645653826212a661c28f080a3896d4adc76980964f30f245a5b357251b09e44ed07f02d09911a6a8dfb3b07c2214e2afb6cda517c163dad31ecc3af916fa2e7fb2213ef0c49e7d689fc2379c5b889b47b97936336e563fc2fcb23479d45a9b6a5913d73bdfd7422cf3a6f72191df3ae40157282566a8940819e6b63b418458bc/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP06.srt&title-1=GOT%20S06%20EP06&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/466ada3f008aa40fc7d5e20bab2ebac0645653826212a661c28f080a3896d4adc76980964f30f245a5b357251b09e44ed07f02d09911a6a8dfb3b07c2214e2afb6cda517c163dad31ecc3af916fa2e7fb2213ef0c49e7d689fc2379c5b889b47b97936336e563fc2fcb23479d45a9b6a5913d73bdfd7422cf3a6f72191df3ae40157282566a8940819e6b63b418458bc/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP06.srt&title-1=GOT%20S06%20EP06&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
});
mapRedirect(["game-of-thrones-s6-ep7"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 06 Episode 7",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/d9d61f7d2c15549d187b6307e42838b3436b92a5f987fa9e5d1073d689b172c3ac3cde9b824a6ce68cea79acb222c3cc112c29fabd538cc390525f57f9b770585cf8b66f224c26539544e16dc13125bf1af6cc1645ceb9a77b73164b2bd57741932c7c93be2f00b061d6027a33d7130ac3e85d8c8d957fabf44b969c410ee6aa0ebf9747bcbff99a8f67c8a14d80dcf9/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP07.srt&title-1=GOT%20S06%20EP07&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/d9d61f7d2c15549d187b6307e42838b3436b92a5f987fa9e5d1073d689b172c3ac3cde9b824a6ce68cea79acb222c3cc112c29fabd538cc390525f57f9b770585cf8b66f224c26539544e16dc13125bf1af6cc1645ceb9a77b73164b2bd57741932c7c93be2f00b061d6027a33d7130ac3e85d8c8d957fabf44b969c410ee6aa0ebf9747bcbff99a8f67c8a14d80dcf9/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP07.srt&title-1=GOT%20S06%20EP07&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
});
mapRedirect(["game-of-thrones-s6-ep8"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 06 Episode 8",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/c20bbf6d35b1bf9fc547291cb82fbc1483a0263e4a3efb4f9caaf1108d096b2df7c6c6801a1d0b66c1044bb9a54de1516b2db1fbc690235f89f0ac3b1d4ab6ebe77c196e41120f9f9c1e8eb5b52f77584896b21bea75adfa5488f372f12fd0896d24b52342564ddc1f39bb98f8f50254287f3389584eb809a7ce437425fcbab8c93dcdbbb8af140dc7202185428fa2e7/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP08.srt&title-1=GOT%20S06%20EP08&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/c20bbf6d35b1bf9fc547291cb82fbc1483a0263e4a3efb4f9caaf1108d096b2df7c6c6801a1d0b66c1044bb9a54de1516b2db1fbc690235f89f0ac3b1d4ab6ebe77c196e41120f9f9c1e8eb5b52f77584896b21bea75adfa5488f372f12fd0896d24b52342564ddc1f39bb98f8f50254287f3389584eb809a7ce437425fcbab8c93dcdbbb8af140dc7202185428fa2e7/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP08.srt&title-1=GOT%20S06%20EP08&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
});
mapRedirect(["game-of-thrones-s6-ep9"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 06 Episode 9",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/675240b372fe25dd3b3aeff4f3dfa9879a1399f0859e403b0e84ad63afe2d6c5a43d1b8eda6b1ada6a350a6b3698abd9b2830383a4c3d6d1773217819b1a7000c1472f01d4c000dc904a8d2e1c95a579b0fcfa3ace0b0dc1835a58e7fb89e4d515ae78344be6e7085aeeb6cb61bdfa357c4892f40c7800fdf50d12a7ed40909748fc53f6abd19d4c19a7476e1b8036b6/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP09.srt&title-1=GOT%20S06%20EP09&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/675240b372fe25dd3b3aeff4f3dfa9879a1399f0859e403b0e84ad63afe2d6c5a43d1b8eda6b1ada6a350a6b3698abd9b2830383a4c3d6d1773217819b1a7000c1472f01d4c000dc904a8d2e1c95a579b0fcfa3ace0b0dc1835a58e7fb89e4d515ae78344be6e7085aeeb6cb61bdfa357c4892f40c7800fdf50d12a7ed40909748fc53f6abd19d4c19a7476e1b8036b6/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP09.srt&title-1=GOT%20S06%20EP09&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
});
mapRedirect(["game-of-thrones-s6-ep10"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 06 Episode 10",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/82814784d8194f92e20ee6b6deb8f747a6786a22d568868196eb7ecb750c304e55185301ba28100b02ea7847274f85b78fa480acf2a829ee4df684c6eddddeca6d1b737eb7f566b49e87963847a6ea954739190d0f1c02e096e180f1687516d58a238da9b511ba49b79d6ebdfee876051bd8b33c0978f2d4631471a17db479f8a9f465d3f32596367ef7bdb9704ba98d/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP10.srt&title-1=GOT%20S06%20EP10&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/82814784d8194f92e20ee6b6deb8f747a6786a22d568868196eb7ecb750c304e55185301ba28100b02ea7847274f85b78fa480acf2a829ee4df684c6eddddeca6d1b737eb7f566b49e87963847a6ea954739190d0f1c02e096e180f1687516d58a238da9b511ba49b79d6ebdfee876051bd8b33c0978f2d4631471a17db479f8a9f465d3f32596367ef7bdb9704ba98d/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S06/GOT.S06.EP10.srt&title-1=GOT%20S06%20EP10&img=https://www.5harfliler.com/wp-content/uploads/2016/07/image1.jpeg",
});

//Game Of Thrones Season 07
mapRedirect(["game-of-thrones-s7-ep1"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 07 Episode 1",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/85058cc7f570efb553674eb4f494bd80ce408284ce695b04e59928096c523e69f5b1fa293cdad94a03964d8cc01b39af1a73a284617e98191a1a2712d71f01a0d4a6c48d2effba7d64f090d153c946111fd18f94545b9fdce3ea4ca8bdc5d361cfed6cec09caeee38da67b8056257717fbe6a83b40872d0025c496a048655819a17068c48be400e37503912f73854de7/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S07/GOT.S07.EP01.srt&title-1=GOT%20S07%20EP01&img=https://jeeta.files.wordpress.com/2019/04/game-of-thrones-season-7-fan-posters-16.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/85058cc7f570efb553674eb4f494bd80ce408284ce695b04e59928096c523e69f5b1fa293cdad94a03964d8cc01b39af1a73a284617e98191a1a2712d71f01a0d4a6c48d2effba7d64f090d153c946111fd18f94545b9fdce3ea4ca8bdc5d361cfed6cec09caeee38da67b8056257717fbe6a83b40872d0025c496a048655819a17068c48be400e37503912f73854de7/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S07/GOT.S07.EP01.srt&title-1=GOT%20S07%20EP01&img=https://jeeta.files.wordpress.com/2019/04/game-of-thrones-season-7-fan-posters-16.jpg",
});
mapRedirect(["game-of-thrones-s7-ep2"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 07 Episode 2",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/fe22f27065cb52b5dfdfadc39d4528718131f23796751b8682ea4bfeb12a21a3b8d2e7404656716ba56441bbb891f9eab1fd2bd05b37e7e2dbe9eaefd3be039d82caddb8be2c2da4cf050316da450b7d3538a172b695cdf0c8fb3854ded3ac8b8bab9536bb2eef283608c21575f69cf3036156cdedfb9d6df5eeb6804a05207f7bcdaf7627b5328f71c2ba4678652f6f/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S07/GOT.S07.EP02.srt&title-1=GOT%20S07%20EP02&img=https://jeeta.files.wordpress.com/2019/04/game-of-thrones-season-7-fan-posters-16.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/fe22f27065cb52b5dfdfadc39d4528718131f23796751b8682ea4bfeb12a21a3b8d2e7404656716ba56441bbb891f9eab1fd2bd05b37e7e2dbe9eaefd3be039d82caddb8be2c2da4cf050316da450b7d3538a172b695cdf0c8fb3854ded3ac8b8bab9536bb2eef283608c21575f69cf3036156cdedfb9d6df5eeb6804a05207f7bcdaf7627b5328f71c2ba4678652f6f/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S07/GOT.S07.EP02.srt&title-1=GOT%20S07%20EP02&img=https://jeeta.files.wordpress.com/2019/04/game-of-thrones-season-7-fan-posters-16.jpg",
});
mapRedirect(["game-of-thrones-s7-ep3"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 07 Episode 3",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/3de28f57ab7473826cf645d72f3e9074129593670dd0ac9afba45db6b37eabfd773624be2d55f354add3cee1b902fd501f8fd28458f6f9927b4bd6c211e8e3d9a2d094cdd3b127e438b66ea08aa67fb38466f6eaa0fb6c9c22567e3d9b4b7f31c1f7a65aebce7521839c178853b70a0c2310ae0b671064347e2274c45bded7c1b6674f4deb73e7a75219a1af8e3d603b/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S07/GOT.S07.EP03.srt&title-1=GOT%20S07%20EP03&img=https://jeeta.files.wordpress.com/2019/04/game-of-thrones-season-7-fan-posters-16.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/3de28f57ab7473826cf645d72f3e9074129593670dd0ac9afba45db6b37eabfd773624be2d55f354add3cee1b902fd501f8fd28458f6f9927b4bd6c211e8e3d9a2d094cdd3b127e438b66ea08aa67fb38466f6eaa0fb6c9c22567e3d9b4b7f31c1f7a65aebce7521839c178853b70a0c2310ae0b671064347e2274c45bded7c1b6674f4deb73e7a75219a1af8e3d603b/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S07/GOT.S07.EP03.srt&title-1=GOT%20S07%20EP03&img=https://jeeta.files.wordpress.com/2019/04/game-of-thrones-season-7-fan-posters-16.jpg",
});
mapRedirect(["game-of-thrones-s7-ep4"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 07 Episode 4",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/44444a15f7f6e3456a783da3e954b853392bee11a85aab1fab03428e8a7d58e76b2822e1977529e9b6ccccc01c8261e5b7bd7cac37146666a325a90b6f3459787f1086c4c0e146bcc1e5f1687f3e5ec1bfe638a8211edc10d983283b88c0a08da431b57a711225107b7d603a019b041fee04e12a25920174ab53ddc2cfe319b88f915d799afa88df5f330c2d6829bd95/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S07/GOT.S07.EP04.srt&title-1=GOT%20S07%20EP04&img=https://jeeta.files.wordpress.com/2019/04/game-of-thrones-season-7-fan-posters-16.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/44444a15f7f6e3456a783da3e954b853392bee11a85aab1fab03428e8a7d58e76b2822e1977529e9b6ccccc01c8261e5b7bd7cac37146666a325a90b6f3459787f1086c4c0e146bcc1e5f1687f3e5ec1bfe638a8211edc10d983283b88c0a08da431b57a711225107b7d603a019b041fee04e12a25920174ab53ddc2cfe319b88f915d799afa88df5f330c2d6829bd95/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S07/GOT.S07.EP04.srt&title-1=GOT%20S07%20EP04&img=https://jeeta.files.wordpress.com/2019/04/game-of-thrones-season-7-fan-posters-16.jpg",
});
mapRedirect(["game-of-thrones-s7-ep5"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 07 Episode 5",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/3502b9190ed43ab5266f0ea7172eabd847ffc81f67e9482233066385b6e6b684d59e1a4c4e94f700462587033cba14227466debd4059283d99c382579cd44d49b13939a9403cec80360bd808227e3086c7bf8bffc2b1a15574c23be63d34c9c8edd1c99ede20d301dd7844c8ca6ffd881cb9f4ae7f45762db4724eabcf33f361a3a0bb98d3b0a0c21eaf952774759ece/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S07/GOT.S07.EP05.srt&title-1=GOT%20S07%20EP05&img=https://jeeta.files.wordpress.com/2019/04/game-of-thrones-season-7-fan-posters-16.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/3502b9190ed43ab5266f0ea7172eabd847ffc81f67e9482233066385b6e6b684d59e1a4c4e94f700462587033cba14227466debd4059283d99c382579cd44d49b13939a9403cec80360bd808227e3086c7bf8bffc2b1a15574c23be63d34c9c8edd1c99ede20d301dd7844c8ca6ffd881cb9f4ae7f45762db4724eabcf33f361a3a0bb98d3b0a0c21eaf952774759ece/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S07/GOT.S07.EP05.srt&title-1=GOT%20S07%20EP05&img=https://jeeta.files.wordpress.com/2019/04/game-of-thrones-season-7-fan-posters-16.jpg",
});
mapRedirect(["game-of-thrones-s7-ep6"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 07 Episode 6",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/8bba0c21b17751efa99536e9717245e3ab4e7dba45da4ffa3a2906329d2f0e5e9e7f1950f723d66dd2f6a4e0551e7c4976a30fe6ff56d7641bcb0259021a205aff90f6129ab7bc7493967642ecdc6aa79f5ef31d2e35f3699c3f2e92c939967eb13713415231718d9178e4a8c4a808cd64f36d717692c045f5c8060b1adb6a048dbb50d3d5300e99bed4edf0d809fd33/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S07/GOT.S07.EP06.srt&title-1=GOT%20S07%20EP06&img=https://jeeta.files.wordpress.com/2019/04/game-of-thrones-season-7-fan-posters-16.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/8bba0c21b17751efa99536e9717245e3ab4e7dba45da4ffa3a2906329d2f0e5e9e7f1950f723d66dd2f6a4e0551e7c4976a30fe6ff56d7641bcb0259021a205aff90f6129ab7bc7493967642ecdc6aa79f5ef31d2e35f3699c3f2e92c939967eb13713415231718d9178e4a8c4a808cd64f36d717692c045f5c8060b1adb6a048dbb50d3d5300e99bed4edf0d809fd33/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S07/GOT.S07.EP06.srt&title-1=GOT%20S07%20EP06&img=https://jeeta.files.wordpress.com/2019/04/game-of-thrones-season-7-fan-posters-16.jpg",
});
mapRedirect(["game-of-thrones-s7-ep7"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 07 Episode 7",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/de9bb9a57a287415e9d79224339a8512c815e954fb4699fb13cd14d9b01e6fcac0f05f2f1344aa2e028a48a3f2effecd6cb56450dae8294af7821956625d0ae8bf2a3d509fcfa54b175a89d0f315bf1b154afcf7b9a32e812098ddd5130e287417b548b90d1058f193e437116768d0df3471b4b334184c06c964d386f1f9e6625ffe9b3ab69d3169d7c6ae70895de02f/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S07/GOT.S07.EP07.srt&title-1=GOT%20S07%20EP07&img=https://jeeta.files.wordpress.com/2019/04/game-of-thrones-season-7-fan-posters-16.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/de9bb9a57a287415e9d79224339a8512c815e954fb4699fb13cd14d9b01e6fcac0f05f2f1344aa2e028a48a3f2effecd6cb56450dae8294af7821956625d0ae8bf2a3d509fcfa54b175a89d0f315bf1b154afcf7b9a32e812098ddd5130e287417b548b90d1058f193e437116768d0df3471b4b334184c06c964d386f1f9e6625ffe9b3ab69d3169d7c6ae70895de02f/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S07/GOT.S07.EP07.srt&title-1=GOT%20S07%20EP07&img=https://jeeta.files.wordpress.com/2019/04/game-of-thrones-season-7-fan-posters-16.jpg",
});

//Game Of Thrones Season 08
mapRedirect(["game-of-thrones-s8-ep1"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 08 Episode 1",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/0a1357536e82e1947890971cc60036500b30efb8722082a2ec2bdeea05b135aaae8508f0c3d0795fb695fc9d6fee2e6d3fbf551e44904cb23f7bc09361b9698917435057a60c83e36e638e42591f9fa8d046a5362c68c9ceb0e6f0daddc94ff537f3007b695ba69937cf4fe8d0de78fc9943e32ef977280463801827117bd2aa3bed904f2ee64903acd74216b1858a27/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S08/GOT.S08.EP01.srt&title-1=GOT%20S08%20EP01&img=https://images2.alphacoders.com/100/1004687.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/0a1357536e82e1947890971cc60036500b30efb8722082a2ec2bdeea05b135aaae8508f0c3d0795fb695fc9d6fee2e6d3fbf551e44904cb23f7bc09361b9698917435057a60c83e36e638e42591f9fa8d046a5362c68c9ceb0e6f0daddc94ff537f3007b695ba69937cf4fe8d0de78fc9943e32ef977280463801827117bd2aa3bed904f2ee64903acd74216b1858a27/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S08/GOT.S08.EP01.srt&title-1=GOT%20S08%20EP01&img=https://images2.alphacoders.com/100/1004687.jpg",
});
mapRedirect(["game-of-thrones-s8-ep2"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 08 Episode 2",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/bfce029db8bea08c337c9ed10d7d2b10814f5a33059a342a9f206328d865bc903e49f13d26e1558de06c5df6098db744552f0660bb915a604f3013f277e8e327673f53c6fcd87b4631dbf1f379c21d9a3b5e1ad34df691473e93e2d423fd607d51c1e0336e4415bbb239cc73102e7d58269941420cea6e8d66ca7d3bbd78fad0574c99b86fb87c93b445377a0a88ee0e/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S08/GOT.S08.EP02.srt&title-1=GOT%20S08%20EP02&img=https://images2.alphacoders.com/100/1004687.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/bfce029db8bea08c337c9ed10d7d2b10814f5a33059a342a9f206328d865bc903e49f13d26e1558de06c5df6098db744552f0660bb915a604f3013f277e8e327673f53c6fcd87b4631dbf1f379c21d9a3b5e1ad34df691473e93e2d423fd607d51c1e0336e4415bbb239cc73102e7d58269941420cea6e8d66ca7d3bbd78fad0574c99b86fb87c93b445377a0a88ee0e/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S08/GOT.S08.EP02.srt&title-1=GOT%20S08%20EP02&img=https://images2.alphacoders.com/100/1004687.jpg",
});
mapRedirect(["game-of-thrones-s8-ep3"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 08 Episode 3",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/0c35386e3ed4ae40e0326fa3be887e1e346b3d90a25ea9b07c0bde011df9bf366ed93c730dae73d0820311a636f52d8e2b619bf32e99e00a4eab4354e70a937997b6ca9c77fdfa56295b436358ff735a5b04c7925d63ca7ca6a16907e7cd7f5e8c7645e83e6f073490eedb7fa6bf925fc357abab9337c4e71c1a040be5f4aaac3dcd4df5cf66a00e1f7cf0db0e7d47fe/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S08/GOT.S08.EP03.srt&title-1=GOT%20S08%20EP03&img=https://images2.alphacoders.com/100/1004687.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/0c35386e3ed4ae40e0326fa3be887e1e346b3d90a25ea9b07c0bde011df9bf366ed93c730dae73d0820311a636f52d8e2b619bf32e99e00a4eab4354e70a937997b6ca9c77fdfa56295b436358ff735a5b04c7925d63ca7ca6a16907e7cd7f5e8c7645e83e6f073490eedb7fa6bf925fc357abab9337c4e71c1a040be5f4aaac3dcd4df5cf66a00e1f7cf0db0e7d47fe/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S08/GOT.S08.EP03.srt&title-1=GOT%20S08%20EP03&img=https://images2.alphacoders.com/100/1004687.jpg",
});
mapRedirect(["game-of-thrones-s8-ep4"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 08 Episode 4",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/5525f0ba3ee09d2242537f70c3b09a18c464505f95d7dfee907784581aaa82cacb4a2fbe24332d6d47cf59610c960e8b53be5ae816d55f7b112476dc8f00b3d0b241a3e8539f75e68d95fe48aeb6c3eb1067d2726058e6f941d505bb5ccb2be8b7ed8401635345bcc7dc65a28697b10c2d7fdb57d308d8e14d004f96052efa55587bffee12f7247f85ddd6086ecdece1/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S08/GOT.S08.EP04.srt&title-1=GOT%20S08%20EP04&img=https://images2.alphacoders.com/100/1004687.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/5525f0ba3ee09d2242537f70c3b09a18c464505f95d7dfee907784581aaa82cacb4a2fbe24332d6d47cf59610c960e8b53be5ae816d55f7b112476dc8f00b3d0b241a3e8539f75e68d95fe48aeb6c3eb1067d2726058e6f941d505bb5ccb2be8b7ed8401635345bcc7dc65a28697b10c2d7fdb57d308d8e14d004f96052efa55587bffee12f7247f85ddd6086ecdece1/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S08/GOT.S08.EP04.srt&title-1=GOT%20S08%20EP04&img=https://images2.alphacoders.com/100/1004687.jpg",
});
mapRedirect(["game-of-thrones-s8-ep5"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 08 Episode 5",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/750ab831a1a12b0721dfeb37c738007ca30e22c95089ef6780138fbb4e93911aca82ef4fde744fcc7722c2ddfd083baa78a7ed05124d3bda6fc4dc4c760814b0b0d7907ef1e2f3a9bd250b8ee9df7b9e9452de6b7e559d0316968394d20aa314a64315eafadf0147131781141b4afe1dbd2c4d9014e7cc139be176b11e2449102e0b37ad3b125e4ad302074f7405648b/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S08/GOT.S08.EP05.srt&title-1=GOT%20S08%20EP05&img=https://images2.alphacoders.com/100/1004687.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/750ab831a1a12b0721dfeb37c738007ca30e22c95089ef6780138fbb4e93911aca82ef4fde744fcc7722c2ddfd083baa78a7ed05124d3bda6fc4dc4c760814b0b0d7907ef1e2f3a9bd250b8ee9df7b9e9452de6b7e559d0316968394d20aa314a64315eafadf0147131781141b4afe1dbd2c4d9014e7cc139be176b11e2449102e0b37ad3b125e4ad302074f7405648b/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S08/GOT.S08.EP05.srt&title-1=GOT%20S08%20EP05&img=https://images2.alphacoders.com/100/1004687.jpg",
});
mapRedirect(["game-of-thrones-s8-ep6"], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game Of Thrones Season 08 Episode 6",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/c537fe98bebfe764ede8fd87ed49a68f445358edd97a154e4cbe663e070aab2c5e4d6d206cc89a12b7d6a0181421548c7dbcd12361d69a3bbb589c911b24e5e396ee651281152bb46e04d6de92a75c69813d3157dd8585905363853d00fed486c07195f20c4e18a6a2ab9c69a633c1aec2e9dce58747cfa50edc738832c478f562747814ccd5268fb77d4f9a09cbef7d/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S08/GOT.S08.EP06.srt&title-1=GOT%20S08%20EP06&img=https://images2.alphacoders.com/100/1004687.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/c537fe98bebfe764ede8fd87ed49a68f445358edd97a154e4cbe663e070aab2c5e4d6d206cc89a12b7d6a0181421548c7dbcd12361d69a3bbb589c911b24e5e396ee651281152bb46e04d6de92a75c69813d3157dd8585905363853d00fed486c07195f20c4e18a6a2ab9c69a633c1aec2e9dce58747cfa50edc738832c478f562747814ccd5268fb77d4f9a09cbef7d/playlist.m3u8&subcode=en&substitleurl=substitles/Series/GOT/GOT.S08/GOT.S08.EP06.srt&title-1=GOT%20S08%20EP06&img=https://images2.alphacoders.com/100/1004687.jpg",
});

//Game Of Thrones - Hindi Dubbed
mapRedirect(["game-of-thrones-season-1-hindi", ""], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game of thrones Season 01 Full - Hindi Dubbed",
    video: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDUvbTNpanI5cTF3cWIyX2gvUHJtb3ZpZXMtR2FtZV9PZl9UaHJvbmVzX1MxX0hpbmRpLm1wND90PTlZVjd1ajB1bDRsTk9TajYxMFZhUHUtUzVpUnh3a1pSR29WbFJ3WFJ0VGsmYW1wO3M9MTcyMTkwNzgxMiZhbXA7ZT0yMTYwMCZhbXA7Zj0yNzk5MyZhbXA7c3A9NTQwJmFtcDtpPTAuMA==",
    video2: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDUvbTNpanI5cTF3cWIyX2gvUHJtb3ZpZXMtR2FtZV9PZl9UaHJvbmVzX1MxX0hpbmRpLm1wND90PTlZVjd1ajB1bDRsTk9TajYxMFZhUHUtUzVpUnh3a1pSR29WbFJ3WFJ0VGsmYW1wO3M9MTcyMTkwNzgxMiZhbXA7ZT0yMTYwMCZhbXA7Zj0yNzk5MyZhbXA7c3A9NTQwJmFtcDtpPTAuMA==",
    enableDownload: false,
    download: "https://proxy.hdmovies2.online/?url=https://walterwhite.ydc1wes.me/v/02/00005/m3ijr9q1wqb2_h/Prmovies-Game_Of_Thrones_S1_Hindi.mp4?t=9YV7uj0ul4lNOSj610VaPu-S5iRxwkZRGoVlRwXRtTk&s=1721907812&e=21600&f=27993&sp=540&i=0.0&download=force",
    para: "Please Wait! While the video loads",
});
mapRedirect(["game-of-thrones-season-2-hindi", ""], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game of thrones Season 02 Full - Hindi Dubbed",
    video: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9yYXNvdXRpbi55ZGMxd2VzLm1lL3YvMDEvMDAwMDUvajZyeWVvMmlra2FwX2gvUHJtb3ZpZXMtR2FtZV9PZl9UaHJvbmVzX1NlYXNvbl8yX0hpbmRpX0R1YmJlZC5tcDQ/dD1JR0Q3THQzOEhaYkNnbEt3dG5BNk5vczJVcXlRZFhEUENLbEphYzduRzBjJmFtcDtzPTE3MjE5MDg2ODImYW1wO2U9MjE2MDAmYW1wO2Y9MjgwMTAmYW1wO3NwPTU0MCZhbXA7aT0wLjA=",
    video2: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9yYXNvdXRpbi55ZGMxd2VzLm1lL3YvMDEvMDAwMDUvajZyeWVvMmlra2FwX2gvUHJtb3ZpZXMtR2FtZV9PZl9UaHJvbmVzX1NlYXNvbl8yX0hpbmRpX0R1YmJlZC5tcDQ/dD1JR0Q3THQzOEhaYkNnbEt3dG5BNk5vczJVcXlRZFhEUENLbEphYzduRzBjJmFtcDtzPTE3MjE5MDg2ODImYW1wO2U9MjE2MDAmYW1wO2Y9MjgwMTAmYW1wO3NwPTU0MCZhbXA7aT0wLjA=",
    enableDownload: false,
    download: "https://proxy.hdmovies2.online/?url=https://rasoutin.ydc1wes.me/v/01/00005/j6ryeo2ikkap_h/Prmovies-Game_Of_Thrones_Season_2_Hindi_Dubbed.mp4?t=IGD7Lt38HZbCglKwtnA6Nos2UqyQdXDPCKlJac7nG0c&s=1721908682&e=21600&f=28010&sp=540&i=0.0&download=force",
    para: "Please Wait! While the video loads",
});
mapRedirect(["game-of-thrones-season-3-hindi", ""], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game of thrones Season 03 Full - Hindi Dubbed",
    video: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9yYXNvdXRpbi55ZGMxd2VzLm1lL3YvMDEvMDAwMDUvOWttM2U1OXIzdWY5X2gvUHJtb3ZpZXMtR2FtZV9PZl9UaHJvbmVzX1MzX0hpbmRpX0R1YmJlZC5tcDQ/dD02bS1tMDAwaFE4WjBuSVJGSkVmMWZfZ21ycnVUN2VQUDhSbVBtZ2hfZ1F3JmFtcDtzPTE3MjE5MDg5MDcmYW1wO2U9MjE2MDAmYW1wO2Y9MjgwMjEmYW1wO3NwPTU0MCZhbXA7aT0wLjA=",
    video2: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9yYXNvdXRpbi55ZGMxd2VzLm1lL3YvMDEvMDAwMDUvOWttM2U1OXIzdWY5X2gvUHJtb3ZpZXMtR2FtZV9PZl9UaHJvbmVzX1MzX0hpbmRpX0R1YmJlZC5tcDQ/dD02bS1tMDAwaFE4WjBuSVJGSkVmMWZfZ21ycnVUN2VQUDhSbVBtZ2hfZ1F3JmFtcDtzPTE3MjE5MDg5MDcmYW1wO2U9MjE2MDAmYW1wO2Y9MjgwMjEmYW1wO3NwPTU0MCZhbXA7aT0wLjA=",
    enableDownload: false,
    download: "https://proxy.hdmovies2.online/?url=https://rasoutin.ydc1wes.me/v/01/00005/9km3e59r3uf9_h/Prmovies-Game_Of_Thrones_S3_Hindi_Dubbed.mp4?t=6m-m000hQ8Z0nIRFJEf1f_gmrruT7ePP8RmPmgh_gQw&s=1721908907&e=21600&f=28021&sp=540&i=0.0&download=force",
    para: "Please Wait! While the video loads",
});
mapRedirect(["game-of-thrones-season-4-hindi", ""], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game of thrones Season 04 Full - Hindi Dubbed",
    video: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9mcmluZ2UueWRjMXdlcy5tZS92LzAxLzAwMDA1L3EwZmY5eWIybDd6OV9oL1BybW92aWVzLUdhbWVfT2ZfVGhyb25lc19TNF9IaW5kaV9EdWJiZWQubXA0P3Q9cGRlYkZUcllHNi1mTlRsTGVnWlRzQWdnZjBWMHRqemhtWnVvS0J4XzJrdyZhbXA7cz0xNzIxOTA5MDk2JmFtcDtlPTIxNjAwJmFtcDtmPTI4MDIyJmFtcDtzcD01NDAmYW1wO2k9MC4w",
    video2: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9mcmluZ2UueWRjMXdlcy5tZS92LzAxLzAwMDA1L3EwZmY5eWIybDd6OV9oL1BybW92aWVzLUdhbWVfT2ZfVGhyb25lc19TNF9IaW5kaV9EdWJiZWQubXA0P3Q9cGRlYkZUcllHNi1mTlRsTGVnWlRzQWdnZjBWMHRqemhtWnVvS0J4XzJrdyZhbXA7cz0xNzIxOTA5MDk2JmFtcDtlPTIxNjAwJmFtcDtmPTI4MDIyJmFtcDtzcD01NDAmYW1wO2k9MC4w",
    enableDownload: false,
    download: "https://proxy.hdmovies2.online/?url=https://fringe.ydc1wes.me/v/01/00005/q0ff9yb2l7z9_h/Prmovies-Game_Of_Thrones_S4_Hindi_Dubbed.mp4?t=pdebFTrYG6-fNTlLegZTsAggf0V0tjzhmZuoKBx_2kw&s=1721909096&e=21600&f=28022&sp=540&i=0.0&download=force",
    para: "Please Wait! While the video loads",
});
mapRedirect(["game-of-thrones-season-5-hindi", ""], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game of thrones Season 05 Full - Hindi Dubbed",
    video: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9kYXZlLnlkYzF3ZXMubWUvdi8wMi8wMDAwNS8ydGVyd2tybGYzMXFfaC9Qcm1vdmllcy1HYW1lX09mX1Rocm9uZXNfUzVfSGluZGlfRHViYmVkLm1wND90PWZRSFZ2WWlabUlxYUdyQ0J0RUxFWkZ1Ul9OTWd5bllGZV90UEIzUlBiUjAmYW1wO3M9MTcyMTkwOTEzNiZhbXA7ZT0yMTYwMCZhbXA7Zj0yODAyMyZhbXA7c3A9NTQwJmFtcDtpPTAuMA==",
    video2: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9kYXZlLnlkYzF3ZXMubWUvdi8wMi8wMDAwNS8ydGVyd2tybGYzMXFfaC9Qcm1vdmllcy1HYW1lX09mX1Rocm9uZXNfUzVfSGluZGlfRHViYmVkLm1wND90PWZRSFZ2WWlabUlxYUdyQ0J0RUxFWkZ1Ul9OTWd5bllGZV90UEIzUlBiUjAmYW1wO3M9MTcyMTkwOTEzNiZhbXA7ZT0yMTYwMCZhbXA7Zj0yODAyMyZhbXA7c3A9NTQwJmFtcDtpPTAuMA==",
    enableDownload: false,
    download: "https://proxy.hdmovies2.online/?url=https://dave.ydc1wes.me/v/02/00005/2terwkrlf31q_h/Prmovies-Game_Of_Thrones_S5_Hindi_Dubbed.mp4?t=fQHVvYiZmIqaGrCBtELEZFuR_NMgynYFe_tPB3RPbR0&s=1721909136&e=21600&f=28023&sp=540&i=0.0&download=force",
    para: "Please Wait! While the video loads",
});
mapRedirect(["game-of-thrones-season-6-hindi", ""], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game of thrones Season 06 Full - Hindi Dubbed",
    video: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9ndXN0YXZvLnlkYzF3ZXMubWUvdi8wMi8wMDAwNS9rM3hpN2Rxa2dxNGhfaC9Qcm1vdmllcy1HYW1lX09mX1Rocm9uZXNfUzZfSGluZGlfRHViYmVkLm1wND90PTMzdy1KSDI1Q3E5dGgzbXhsRWtKY1BvMUR0TGZyaUhSeWI2ZkFxcXd2RGcmYW1wO3M9MTcyMTkwOTE3NCZhbXA7ZT0yMTYwMCZhbXA7Zj0yODAyNCZhbXA7c3A9NTQwJmFtcDtpPTAuMA==",
    video2: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9ndXN0YXZvLnlkYzF3ZXMubWUvdi8wMi8wMDAwNS9rM3hpN2Rxa2dxNGhfaC9Qcm1vdmllcy1HYW1lX09mX1Rocm9uZXNfUzZfSGluZGlfRHViYmVkLm1wND90PTMzdy1KSDI1Q3E5dGgzbXhsRWtKY1BvMUR0TGZyaUhSeWI2ZkFxcXd2RGcmYW1wO3M9MTcyMTkwOTE3NCZhbXA7ZT0yMTYwMCZhbXA7Zj0yODAyNCZhbXA7c3A9NTQwJmFtcDtpPTAuMA==",
    enableDownload: false,
    download: "https://proxy.hdmovies2.online/?url=https://gustavo.ydc1wes.me/v/02/00005/k3xi7dqkgq4h_h/Prmovies-Game_Of_Thrones_S6_Hindi_Dubbed.mp4?t=33w-JH25Cq9th3mxlEkJcPo1DtLfriHRyb6fAqqwvDg&s=1721909174&e=21600&f=28024&sp=540&i=0.0&download=force",
    para: "Please Wait! While the video loads",
});
mapRedirect(["game-of-thrones-season-7-hindi", ""], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game of thrones Season 07 Full - Hindi Dubbed",
    video: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9yZXF1dG8ueWRjMXdlcy5tZS92LzAxLzAwMDA1L3BrZmNtMnZtbnkxMF9oL1BybW92aWVzLUdhbWVfT2ZfVGhyb25lc19TN19IaW5kaV9EdWJiZWQubXA0P3Q9UE8tM0hwSWhoU1oxMDU0bG9aTVVscGVuWHVodXIwUTk1T1F3X0R5M09abyZhbXA7cz0xNzIxOTA5MjEzJmFtcDtlPTIxNjAwJmFtcDtmPTI4MDQyJmFtcDtzcD01NDAmYW1wO2k9MC4w",
    video2: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9yZXF1dG8ueWRjMXdlcy5tZS92LzAxLzAwMDA1L3BrZmNtMnZtbnkxMF9oL1BybW92aWVzLUdhbWVfT2ZfVGhyb25lc19TN19IaW5kaV9EdWJiZWQubXA0P3Q9UE8tM0hwSWhoU1oxMDU0bG9aTVVscGVuWHVodXIwUTk1T1F3X0R5M09abyZhbXA7cz0xNzIxOTA5MjEzJmFtcDtlPTIxNjAwJmFtcDtmPTI4MDQyJmFtcDtzcD01NDAmYW1wO2k9MC4w",
    enableDownload: false,
    download: "https://proxy.hdmovies2.online/?url=https://requto.ydc1wes.me/v/01/00005/pkfcm2vmny10_h/Prmovies-Game_Of_Thrones_S7_Hindi_Dubbed.mp4?t=PO-3HpIhhSZ1054loZMUlpenXuhur0Q95OQw_Dy3OZo&s=1721909213&e=21600&f=28042&sp=540&i=0.0&download=force",
    para: "Please Wait! While the video loads",
});
mapRedirect(["game-of-thrones-season-8-hindi", ""], {
    splashimgurl: "https://storiesbywilliams.files.wordpress.com/2012/12/game-of-thrones-wallpaper.jpg",
    title: "Watch Game of thrones Season 08 Full - Hindi Dubbed",
    video: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9hcm1hbnRvdC55ZGMxd2VzLm1lL3YvMDEvMDAwMDUvbWxyYnY4NTU1azhwX2gvUHJtb3ZpZXMtR2FtZV9PZl9UaHJvbmVzX1M4X0hpbmRpX0R1YmJlZC5tcDQ/dD13bEk4MHpUb2szSnlEelZaaWdmaFRqRmFRODN3bllfOWtkRmZ1NHNiaWFzJmFtcDtzPTE3MjE5MDkyNjYmYW1wO2U9MjE2MDAmYW1wO2Y9MjgwNDEmYW1wO3NwPTU0MCZhbXA7aT0wLjA=",
    video2: "https://proxy.hdmovies2.online/?cdURL=aHR0cHM6Ly9hcm1hbnRvdC55ZGMxd2VzLm1lL3YvMDEvMDAwMDUvbWxyYnY4NTU1azhwX2gvUHJtb3ZpZXMtR2FtZV9PZl9UaHJvbmVzX1M4X0hpbmRpX0R1YmJlZC5tcDQ/dD13bEk4MHpUb2szSnlEelZaaWdmaFRqRmFRODN3bllfOWtkRmZ1NHNiaWFzJmFtcDtzPTE3MjE5MDkyNjYmYW1wO2U9MjE2MDAmYW1wO2Y9MjgwNDEmYW1wO3NwPTU0MCZhbXA7aT0wLjA=",
    enableDownload: false,
    download: "https://proxy.hdmovies2.online/?url=https://armantot.ydc1wes.me/v/01/00005/mlrbv8555k8p_h/Prmovies-Game_Of_Thrones_S8_Hindi_Dubbed.mp4?t=wlI80zTok3JyDzVZigfhTjFaQ83wnY_9kdFfu4sbias&s=1721909266&e=21600&f=28041&sp=540&i=0.0&download=force",
    para: "Please Wait! While the video loads",
});

//House of the Dragon Season 1
mapRedirect(["house-of-the-dragon-s1-ep1"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/s2lpKvS7u5fg9eNvWYbWaM7pNFR.jpg",
    title: "Watch House of the Dragon Season 01 Episode 01 With English Subtitle",
    para: "AD Blocker Recommended",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=1&episode=1&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/ec0ca060021bff4f15fc60c313bcc0c38f343f80e388f8647d2d8ce5db563786857e9f25fb630d8a08b0e889f3b16bb65a57ba0aa40134c0167cd75a199204a48e1dfffd5d96aa660b2e053ee99c8168ad282aac95c994f9b1cc9b08d1ea576e4f37fd475678371bf1e967b508c47e312cd4ab58a653d6de150187d0d7c69b6c88d3af70aa6a644eb06a3ae04a81a6b6/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep01.srt&title-1=HOTD S1 EP1&img=https://static.hbo.com/2022-09/house-of-the-dragon-sn01-v2-ka-1920.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/ec0ca060021bff4f15fc60c313bcc0c38f343f80e388f8647d2d8ce5db563786857e9f25fb630d8a08b0e889f3b16bb65a57ba0aa40134c0167cd75a199204a48e1dfffd5d96aa660b2e053ee99c8168ad282aac95c994f9b1cc9b08d1ea576e4f37fd475678371bf1e967b508c47e312cd4ab58a653d6de150187d0d7c69b6c88d3af70aa6a644eb06a3ae04a81a6b6/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep01.srt&title-1=HOTD S1 EP1&img=https://static.hbo.com/2022-09/house-of-the-dragon-sn01-v2-ka-1920.jpg",
});
mapRedirect(["house-of-the-dragon-s1-ep2"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/s2lpKvS7u5fg9eNvWYbWaM7pNFR.jpg",
    title: "Watch House of the Dragon Season 01 Episode 02 With English Subtitle",
    para: "AD Blocker Recommended",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=1&episode=2&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/168c48bcedf7d37b096096da816d4b063296b3b0598aa2487a45b3f65fdefc74ee2b8b35c0b2d18410e650d1f83cb56f678123a7c5244f025e5eb5a8026c13ab3bab4dc8bede2bad2b321e4973f28ff14b229ad163b739f16040d7bb2b140bf29094af5d2f9ffa3b2d9e28d63ff41479aab6f96db67b8a898e810696774a9027f946f5ff7c6ad2cb69af0f7966e76b87/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep02.srt&title-1=HOTD S1 EP2&img=https://cdn.mos.cms.futurecdn.net/bpYWArbor7k9UvsAzeUn2P.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/168c48bcedf7d37b096096da816d4b063296b3b0598aa2487a45b3f65fdefc74ee2b8b35c0b2d18410e650d1f83cb56f678123a7c5244f025e5eb5a8026c13ab3bab4dc8bede2bad2b321e4973f28ff14b229ad163b739f16040d7bb2b140bf29094af5d2f9ffa3b2d9e28d63ff41479aab6f96db67b8a898e810696774a9027f946f5ff7c6ad2cb69af0f7966e76b87/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep02.srt&title-1=HOTD S1 EP2&img=https://cdn.mos.cms.futurecdn.net/bpYWArbor7k9UvsAzeUn2P.jpg",
});
mapRedirect(["house-of-the-dragon-s1-ep3"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/s2lpKvS7u5fg9eNvWYbWaM7pNFR.jpg",
    title: "Watch House of the Dragon Season 01 Episode 03 With English Subtitle",
    para: "AD Blocker Recommended",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=1&episode=3&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/287444dd49c975ff8c3f0951991b65abccf5a7caf7fb6937a7a367a36d3bce53b15d01738926926d6cc4f5e4710c0bbf82d6cc01cdc2a89db59ee5cccd192c28b3a1cf76b3717b491c31e6126765887087af877f00d729275a5576715514e232fc86a4b6562df8f2c02e9bfb261a7fa68ccfa54891fea300f6ef5bbff92bac3ae71d9f7a46ee3c38554893472c9f46fc/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep03.srt&title-1=HOTD S1 EP3&img=https://media.newyorker.com/photos/6356b239c3ba33bf06d7ad87/master/pass/Chayka-Dragons.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/287444dd49c975ff8c3f0951991b65abccf5a7caf7fb6937a7a367a36d3bce53b15d01738926926d6cc4f5e4710c0bbf82d6cc01cdc2a89db59ee5cccd192c28b3a1cf76b3717b491c31e6126765887087af877f00d729275a5576715514e232fc86a4b6562df8f2c02e9bfb261a7fa68ccfa54891fea300f6ef5bbff92bac3ae71d9f7a46ee3c38554893472c9f46fc/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep03.srt&title-1=HOTD S1 EP3&img=https://media.newyorker.com/photos/6356b239c3ba33bf06d7ad87/master/pass/Chayka-Dragons.jpg",
});
mapRedirect(["house-of-the-dragon-s1-ep4"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/s2lpKvS7u5fg9eNvWYbWaM7pNFR.jpg",
    title: "Watch House of the Dragon Season 01 Episode 04 With English Subtitle",
    para: "AD Blocker Recommended",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=1&episode=4&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/088a3808bf9a25265c182ab6776cabf9699878fa98b76c6bafe4eb0cd2d85a44c6c22ca4bd12b436eac646fc8d3ba0f77ae0054d7bdb4cb562eb159fb17889f9fef8578a94017569a5247abdc6fb20eec3a88df0c6667c940c43c76ce8d77335032a7d025a0d77d439c1bd7a8b5665690bc353d7d0573fd74f505deb320c8fe220ed80934c6146d10c717c8c955ad4c9/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep04.srt&title-1=HOTD S1 EP4&img=https://static.hbo.com/2022-09/house-of-the-dragon-sn01-v2-ka-1920.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/088a3808bf9a25265c182ab6776cabf9699878fa98b76c6bafe4eb0cd2d85a44c6c22ca4bd12b436eac646fc8d3ba0f77ae0054d7bdb4cb562eb159fb17889f9fef8578a94017569a5247abdc6fb20eec3a88df0c6667c940c43c76ce8d77335032a7d025a0d77d439c1bd7a8b5665690bc353d7d0573fd74f505deb320c8fe220ed80934c6146d10c717c8c955ad4c9/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep04.srt&title-1=HOTD S1 EP4&img=https://static.hbo.com/2022-09/house-of-the-dragon-sn01-v2-ka-1920.jpg",
});
mapRedirect(["house-of-the-dragon-s1-ep5"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/s2lpKvS7u5fg9eNvWYbWaM7pNFR.jpg",
    title: "Watch House of the Dragon Season 01 Episode 05 With English Subtitle",
    para: "AD Blocker Recommended",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=1&episode=5&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/a51433a963749f883d27fac21e56cd32d7faf7aca3e9efba2b9437aa9a909b91f74d4b194a0de6a1e3ddd1b2f27e242abee1b735b93473dd033160b6dee33cd45143831ba5b7cbaf82fb5239ab39a13a4fa70ee49c60026d980216be68b7810bed023e07d91bb259e257d9c7b3e8bcb81539a2bacbd2da315fa45255b681d6a732dd9fa54a2b5dc8dd49193c6a7fd03a/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep05.srt&title-1=HOTD S1 EP5&img=https://cdn.mos.cms.futurecdn.net/bpYWArbor7k9UvsAzeUn2P.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/a51433a963749f883d27fac21e56cd32d7faf7aca3e9efba2b9437aa9a909b91f74d4b194a0de6a1e3ddd1b2f27e242abee1b735b93473dd033160b6dee33cd45143831ba5b7cbaf82fb5239ab39a13a4fa70ee49c60026d980216be68b7810bed023e07d91bb259e257d9c7b3e8bcb81539a2bacbd2da315fa45255b681d6a732dd9fa54a2b5dc8dd49193c6a7fd03a/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep05.srt&title-1=HOTD S1 EP5&img=https://cdn.mos.cms.futurecdn.net/bpYWArbor7k9UvsAzeUn2P.jpg",
});
mapRedirect(["house-of-the-dragon-s1-ep6"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/s2lpKvS7u5fg9eNvWYbWaM7pNFR.jpg",
    title: "Watch House of the Dragon Season 01 Episode 06 With English Subtitle",
    para: "AD Blocker Recommended",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=1&episode=6&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/11af9ef3e1b32367c9c6b1fd557fcecf9612d1261e970d28c7938d224c471fb479a51da3b78c440a4cf81613ae07ef2b2b07359aa97744bf234c70a47673cb9b653068455b15d8ea0974b2d455675f37ebbedf729766e7d050c209764128679af3ac449281374cce131870df5eab056b596386cd2280b60a3f58d77c2ac2c5019cf45d15e347d0c4382e18f29bafa7c9/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep06.srt&title-1=HOTD S1 EP6&img=https://media.newyorker.com/photos/6356b239c3ba33bf06d7ad87/master/pass/Chayka-Dragons.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/11af9ef3e1b32367c9c6b1fd557fcecf9612d1261e970d28c7938d224c471fb479a51da3b78c440a4cf81613ae07ef2b2b07359aa97744bf234c70a47673cb9b653068455b15d8ea0974b2d455675f37ebbedf729766e7d050c209764128679af3ac449281374cce131870df5eab056b596386cd2280b60a3f58d77c2ac2c5019cf45d15e347d0c4382e18f29bafa7c9/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep06.srt&title-1=HOTD S1 EP6&img=https://media.newyorker.com/photos/6356b239c3ba33bf06d7ad87/master/pass/Chayka-Dragons.jpg",
});
mapRedirect(["house-of-the-dragon-s1-ep7"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/s2lpKvS7u5fg9eNvWYbWaM7pNFR.jpg",
    title: "Watch House of the Dragon Season 01 Episode 07 With English Subtitle",
    para: "AD Blocker Recommended",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=1&episode=7&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/7abab98cc40a80d9d4ffe0f395a21d5a17db7b04114afe25e32c73c9bb370cdf6f76e6a2aff05ac4bbbaf8c162f99d79d58d7a409f824d4a3aae8eaae33427ba8369ef1d73c5f04c36c43c4b7462bb76053a065079c25dbcbd2b197ce25cbc047764eb22f0a449b76b6248ef1400dde44d5d32ed6353e6e60ac6d70d94e8a24a76661497936243e4e37ce3718918f509/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep07.srt&title-1=HOTD S1 EP7&img=https://static.hbo.com/2022-09/house-of-the-dragon-sn01-v2-ka-1920.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/7abab98cc40a80d9d4ffe0f395a21d5a17db7b04114afe25e32c73c9bb370cdf6f76e6a2aff05ac4bbbaf8c162f99d79d58d7a409f824d4a3aae8eaae33427ba8369ef1d73c5f04c36c43c4b7462bb76053a065079c25dbcbd2b197ce25cbc047764eb22f0a449b76b6248ef1400dde44d5d32ed6353e6e60ac6d70d94e8a24a76661497936243e4e37ce3718918f509/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep07.srt&title-1=HOTD S1 EP7&img=https://static.hbo.com/2022-09/house-of-the-dragon-sn01-v2-ka-1920.jpg",
});
mapRedirect(["house-of-the-dragon-s1-ep8"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/s2lpKvS7u5fg9eNvWYbWaM7pNFR.jpg",
    title: "Watch House of the Dragon Season 01 Episode 08 With English Subtitle",
    para: "AD Blocker Recommended",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=1&episode=8&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/0b1eb3ebb4bfb87d05a1eaccce1fd607e8dba24b8bce83aa9d90ef9b90bec6828d2f21f116031778c79a7349d274d8c0d8d19cf974abbc76f759c90afec806c5711cfaf9dd8d6e0c9dd1623b0b1784be15385f968c7762af09b0675fb9373d71aa169c4ab6c3d3bf42099ceb900028ea5188c841de250755cd7216ff8f81da56d1a57cebfffd0a03cf8f357e9564b8be/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep08.srt&title-1=HOTD S1 EP8&img=https://cdn.mos.cms.futurecdn.net/bpYWArbor7k9UvsAzeUn2P.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/0b1eb3ebb4bfb87d05a1eaccce1fd607e8dba24b8bce83aa9d90ef9b90bec6828d2f21f116031778c79a7349d274d8c0d8d19cf974abbc76f759c90afec806c5711cfaf9dd8d6e0c9dd1623b0b1784be15385f968c7762af09b0675fb9373d71aa169c4ab6c3d3bf42099ceb900028ea5188c841de250755cd7216ff8f81da56d1a57cebfffd0a03cf8f357e9564b8be/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep08.srt&title-1=HOTD S1 EP8&img=https://cdn.mos.cms.futurecdn.net/bpYWArbor7k9UvsAzeUn2P.jpg",
});
mapRedirect(["house-of-the-dragon-s1-ep9"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/s2lpKvS7u5fg9eNvWYbWaM7pNFR.jpg",
    title: "Watch House of the Dragon Season 01 Episode 09 With English Subtitle",
    para: "AD Blocker Recommended",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=1&episode=9&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/138f3373584ec51daf4a1a00e6c0dce9e843cf4d611f515c69a86a413c855f8f5c26013d6570529dd6fe3f4ad9b19660be2f0e10f170728ad8bfa2e8babc6fa950d715966542f9881182a5bb4713bb74e4ee8f8189cfb895697b3e3be7d26968a8eaabdea1cc8d720bec6824e4292744deb3bf2724e2905d93875a63e15216fbb3efc2f7da384c265c49f6596009f867/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep09.srt&title-1=HOTD S1 EP9&img=https://media.newyorker.com/photos/6356b239c3ba33bf06d7ad87/master/pass/Chayka-Dragons.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/138f3373584ec51daf4a1a00e6c0dce9e843cf4d611f515c69a86a413c855f8f5c26013d6570529dd6fe3f4ad9b19660be2f0e10f170728ad8bfa2e8babc6fa950d715966542f9881182a5bb4713bb74e4ee8f8189cfb895697b3e3be7d26968a8eaabdea1cc8d720bec6824e4292744deb3bf2724e2905d93875a63e15216fbb3efc2f7da384c265c49f6596009f867/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep09.srt&title-1=HOTD S1 EP9&img=https://media.newyorker.com/photos/6356b239c3ba33bf06d7ad87/master/pass/Chayka-Dragons.jpg",
});
mapRedirect(["house-of-the-dragon-s1-ep10"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/s2lpKvS7u5fg9eNvWYbWaM7pNFR.jpg",
    title: "Watch House of the Dragon Season 01 Episode 10 With English Subtitle",
    para: "AD Blocker Recommended",
    //video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=1&episode=10&ds_lang=en",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/a08340630acb35e8287029a089d906f98b2c9b8b814d11347aa229757454322139208640eaf02102b9a14277d6df07bba1754a240eb1cede863c94dc2448c5a40b97ce922d2420ceb3efa8cf91d50f1187ae2c8f846742aad23230101e0e1c1c6b276bd5b4602cde140d5b656598564f0efe5c6e0eb5a2b791779e0a45b5733a8d26bfb8e13692d608d66507697d80f4/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep10.srt&title-1=HOTD S1 EP10&img=https://static.hbo.com/2022-09/house-of-the-dragon-sn01-v2-ka-1920.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/a08340630acb35e8287029a089d906f98b2c9b8b814d11347aa229757454322139208640eaf02102b9a14277d6df07bba1754a240eb1cede863c94dc2448c5a40b97ce922d2420ceb3efa8cf91d50f1187ae2c8f846742aad23230101e0e1c1c6b276bd5b4602cde140d5b656598564f0efe5c6e0eb5a2b791779e0a45b5733a8d26bfb8e13692d608d66507697d80f4/playlist.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s01/hotd.s01.ep10.srt&title-1=HOTD S1 EP10&img=https://static.hbo.com/2022-09/house-of-the-dragon-sn01-v2-ka-1920.jpg",
});

//House of the dragon Season 02
mapRedirect(["house-of-the-dragon-s2-ep1"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/3jQD3gSbIcckqfdFj9qOAv8NDqF.jpg",
    title: "Watch House of the Dragon Season 02 Episode 1 With English Subtitle",
    video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=1&ds_lang=en",
    video2: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=1&ds_lang=en",
    //video: "series.html?source=https://tmdrv.vidsrc.stream/stream/H4sIAAAAAAAAAw3JyVKDMAAA0F9i1eJNplkGJZhMFsgtIcWMDUiLIvD19vQOb3DFMBR9dkmHU548X1xqTWTs4J4epnn_wq7z3kNYd4lmBLqFnGFnMMT2KDcb6oyPENdg5jIBuTjDjMZzaQHLONgmEb4jIbudJTGySCOB9UctwubEBmgkjgY_LlSrRnIhkFRdeF1NVFGm9E7HOaMTuYkvtlrlvFFSElQfci9ameqJxcQoFDfyKlYW9I9VfnGgWsRUcT7S3OLQdvGMeuXvPfDSKfjeYwgYOiUG.JuFmtbS3zkPb137GZup_G1w.SdQkQnoDwXlStNZ_wO2zAzLIQEAAA--/master.m3u8&subcode=en&substitleurl=substitles/series/got/hotd.s02/hotd.s02.ep1.srt&title-1=HOTD S2 EP1&img=https://image.tmdb.org/t/p/original/xtAQ7j9Yd0j4Rjbvx1hW0ENpXjf.jpg",
});
mapRedirect(["house-of-the-dragon-s2-ep2"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/3jQD3gSbIcckqfdFj9qOAv8NDqF.jpg",
    title: "Watch House of the Dragon Season 02 Episode 2 With English Subtitle",
    para: "AD Blocker Recommended",
    video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=2&ds_lang=en",
    video2: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=2&ds_lang=en",
    //video: "series.html?source=&subcode=en&substitleurl=substitles/series/got/hotd.s02/hotd.s02.ep2.srt&title-1=HOTD S2 EP2&img=https://image.tmdb.org/t/p/original/xtAQ7j9Yd0j4Rjbvx1hW0ENpXjf.jpg",
});
mapRedirect(["house-of-the-dragon-s2-ep3"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/3jQD3gSbIcckqfdFj9qOAv8NDqF.jpg",
    title: "Watch House of the Dragon Season 02 Episode 3 With English Subtitle",
    para: "AD Blocker Recommended",
    video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=3&ds_lang=en",
    video2: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=3&ds_lang=en",
    //video: "series.html?source=&subcode=en&substitleurl=substitles/series/got/hotd.s02/hotd.s02.ep3.srt&title-1=HOTD S2 EP3&img=https://image.tmdb.org/t/p/original/xtAQ7j9Yd0j4Rjbvx1hW0ENpXjf.jpg",
});
mapRedirect(["house-of-the-dragon-s2-ep4"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/3jQD3gSbIcckqfdFj9qOAv8NDqF.jpg",
    title: "Watch House of the Dragon Season 02 Episode 4 With English Subtitle",
    para: "AD Blocker Recommended",
    video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=4&ds_lang=en",
    video2: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=4&ds_lang=en",
    //video: "series.html?source=&subcode=en&substitleurl=substitles/series/got/hotd.s02/hotd.s02.ep4.srt&title-1=HOTD S2 EP4&img=https://image.tmdb.org/t/p/original/xtAQ7j9Yd0j4Rjbvx1hW0ENpXjf.jpg",
});
mapRedirect(["house-of-the-dragon-s2-ep5"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/3jQD3gSbIcckqfdFj9qOAv8NDqF.jpg",
    title: "Watch House of the Dragon Season 02 Episode 5 With English Subtitle (Air Date: 14 July 2024)",
    para: "AD Blocker Recommended",
    video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=5&ds_lang=en",
    video2: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=5&ds_lang=en",
    //video: "series.html?source=&subcode=en&substitleurl=substitles/series/got/hotd.s02/hotd.s02.ep5.srt&title-1=HOTD S2 EP5&img=https://image.tmdb.org/t/p/original/xtAQ7j9Yd0j4Rjbvx1hW0ENpXjf.jpg",
});
mapRedirect(["house-of-the-dragon-s2-ep6"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/3jQD3gSbIcckqfdFj9qOAv8NDqF.jpg",
    title: "Watch House of the Dragon Season 02 Episode 6 With English Subtitle (Air Date: 21 July 2024)",
    para: "AD Blocker Recommended",
    video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=6&ds_lang=en",
    video2: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=6&ds_lang=en",
    //video: "series.html?source=&subcode=en&substitleurl=substitles/series/got/hotd.s02/hotd.s02.ep6.srt&title-1=HOTD S2 EP6&img=https://image.tmdb.org/t/p/original/xtAQ7j9Yd0j4Rjbvx1hW0ENpXjf.jpg",
});
mapRedirect(["house-of-the-dragon-s2-ep7"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/3jQD3gSbIcckqfdFj9qOAv8NDqF.jpg",
    title: "Watch House of the Dragon Season 02 Episode 7 With English Subtitle (Air Date: 28 July 2024)",
    para: "AD Blocker Recommended",
    video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=7&ds_lang=en",
    video2: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=7&ds_lang=en",
    //video: "series.html?source=&subcode=en&substitleurl=substitles/series/got/hotd.s02/hotd.s02.ep7.srt&title-1=HOTD S2 EP7&img=https://image.tmdb.org/t/p/original/xtAQ7j9Yd0j4Rjbvx1hW0ENpXjf.jpg",
});
mapRedirect(["house-of-the-dragon-s2-ep8"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/3jQD3gSbIcckqfdFj9qOAv8NDqF.jpg",
    title: "Watch House of the Dragon Season 02 Episode 8(Final) With English Subtitle (Air Date: 4 August 2024)",
    para: "AD Blocker Recommended",
    video: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=8&ds_lang=en",
    video2: "https://vidsrc.xyz/embed/tv?tmdb=94997&season=2&episode=8&ds_lang=en",
    //video: "series.html?source=&subcode=en&substitleurl=substitles/series/got/hotd.s02/hotd.s02.ep8.srt&title-1=HOTD S2 EP8&img=https://image.tmdb.org/t/p/original/xtAQ7j9Yd0j4Rjbvx1hW0ENpXjf.jpg",
});

//Rise Of Empires: Ottoman Season 01
mapRedirect(["rise-of-empires-ottoman-s1-ep1"], {
    splashimgurl: "https://m.media-amazon.com/images/M/MV5BM2EwZmQxYzYtNzFjNy00YWMxLWE0MTktNjE3ZjZhNTNlN2Q1XkEyXkFqcGdeQXVyOTkzODAxNTE@._V1_.jpg",
    title: "Watch Rise of Empires: Ottoman Season 01 Episode 1 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/50a07c346acbddeacd67796bff0d01fc753c0eb05ef1d2feb51c3ee00ec7fc3964ef384f0bda42417b3552c248c8d7bd3272c53a2214bf545e8f8ca297a9f3ec61c12bab48ea5559aa5b20e1b247230361c9f43e6181e454d823dc559390cbafc87f517d787284307f700e0d869d2d3c4ae9e71a7eaa157bef7c890f6d89ccd87fe78ad7d88988dcfa82464cb3313231/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s01.ep1.srt&title-1=ROE:Ottoman S1 EP1&img=https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p17810281_b_h9_ac.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/50a07c346acbddeacd67796bff0d01fc753c0eb05ef1d2feb51c3ee00ec7fc3964ef384f0bda42417b3552c248c8d7bd3272c53a2214bf545e8f8ca297a9f3ec61c12bab48ea5559aa5b20e1b247230361c9f43e6181e454d823dc559390cbafc87f517d787284307f700e0d869d2d3c4ae9e71a7eaa157bef7c890f6d89ccd87fe78ad7d88988dcfa82464cb3313231/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s01.ep1.srt&title-1=ROE:Ottoman S1 EP1&img=https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p17810281_b_h9_ac.jpg",
});
mapRedirect(["rise-of-empires-ottoman-s1-ep2"], {
    splashimgurl: "https://m.media-amazon.com/images/M/MV5BM2EwZmQxYzYtNzFjNy00YWMxLWE0MTktNjE3ZjZhNTNlN2Q1XkEyXkFqcGdeQXVyOTkzODAxNTE@._V1_.jpg",
    title: "Watch Rise of Empires: Ottoman Season 01 Episode 2 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/ef13e904b2ba06e48ea751d9df5b7815a635e813495e58dd88317650b583fd9fc48743185564a5db61e75f7d0bc84be3ac50bca6f3f289558b72a0df93a596ea90a658fb7425cd43a9a680cc9f6b1ce9bd17948aa442fee66c36ddde2a21b5adda355cdc62b8b8e4b78b90b79990bc4b41517555b9c1ce8685694e1a2dd5c098c0ee60ea2c5784133ed54894d952c2b8/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s01.ep2.srt&title-1=ROE:Ottoman S1 EP2&img=https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p17810281_b_h9_ac.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/ef13e904b2ba06e48ea751d9df5b7815a635e813495e58dd88317650b583fd9fc48743185564a5db61e75f7d0bc84be3ac50bca6f3f289558b72a0df93a596ea90a658fb7425cd43a9a680cc9f6b1ce9bd17948aa442fee66c36ddde2a21b5adda355cdc62b8b8e4b78b90b79990bc4b41517555b9c1ce8685694e1a2dd5c098c0ee60ea2c5784133ed54894d952c2b8/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s01.ep2.srt&title-1=ROE:Ottoman S1 EP2&img=https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p17810281_b_h9_ac.jpg",
});
mapRedirect(["rise-of-empires-ottoman-s1-ep3"], {
    splashimgurl: "https://m.media-amazon.com/images/M/MV5BM2EwZmQxYzYtNzFjNy00YWMxLWE0MTktNjE3ZjZhNTNlN2Q1XkEyXkFqcGdeQXVyOTkzODAxNTE@._V1_.jpg",
    title: "Watch Rise of Empires: Ottoman Season 01 Episode 3 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/3c8f53f08daf3a835428c67b3242a7482659038c904f38236d6b817b5b83b098e1b1860acb93dc92d9484d0c8e27246bf437c15b8b7c728d4504e40ad2d5761b2f397e55eb4fedaed6e5c7fd13d2f2f7762227c2e1d59a2dc83c6139b3db44b226f094204a3c7040974c2615303b515c8065797b5b48795197fedad0c465fa8a1f4565684c91b667287220ca65845c96/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s01.ep3.srt&title-1=ROE:Ottoman S1 EP3&img=https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p17810281_b_h9_ac.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/3c8f53f08daf3a835428c67b3242a7482659038c904f38236d6b817b5b83b098e1b1860acb93dc92d9484d0c8e27246bf437c15b8b7c728d4504e40ad2d5761b2f397e55eb4fedaed6e5c7fd13d2f2f7762227c2e1d59a2dc83c6139b3db44b226f094204a3c7040974c2615303b515c8065797b5b48795197fedad0c465fa8a1f4565684c91b667287220ca65845c96/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s01.ep3.srt&title-1=ROE:Ottoman S1 EP3&img=https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p17810281_b_h9_ac.jpg",
});
mapRedirect(["rise-of-empires-ottoman-s1-ep4"], {
    splashimgurl: "https://m.media-amazon.com/images/M/MV5BM2EwZmQxYzYtNzFjNy00YWMxLWE0MTktNjE3ZjZhNTNlN2Q1XkEyXkFqcGdeQXVyOTkzODAxNTE@._V1_.jpg",
    title: "Watch Rise of Empires: Ottoman Season 01 Episode 4 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/0c2e15f3eb509dff6bdc0247b0db57a55b5fc3270979fd0a07248115fe15a3bd6016cee45081d23e2fc9044de823e9ce314fe8ecbec04fd15b46cd03f9775cf4513047bfd9f0612e19be50b8d669ca72b2bb4491fa0549e5d1479420061b5aa638068993c27fc3b52cf35eda11aa4b5df856e0e1fbfbf11314299c8b1f1f8dcaaa51e76df2c5fa631470eb7d39539e7b/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s01.ep4.srt&title-1=ROE:Ottoman S1 EP4&img=https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p17810281_b_h9_ac.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/0c2e15f3eb509dff6bdc0247b0db57a55b5fc3270979fd0a07248115fe15a3bd6016cee45081d23e2fc9044de823e9ce314fe8ecbec04fd15b46cd03f9775cf4513047bfd9f0612e19be50b8d669ca72b2bb4491fa0549e5d1479420061b5aa638068993c27fc3b52cf35eda11aa4b5df856e0e1fbfbf11314299c8b1f1f8dcaaa51e76df2c5fa631470eb7d39539e7b/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s01.ep4.srt&title-1=ROE:Ottoman S1 EP4&img=https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p17810281_b_h9_ac.jpg",
});
mapRedirect(["rise-of-empires-ottoman-s1-ep5"], {
    splashimgurl: "https://m.media-amazon.com/images/M/MV5BM2EwZmQxYzYtNzFjNy00YWMxLWE0MTktNjE3ZjZhNTNlN2Q1XkEyXkFqcGdeQXVyOTkzODAxNTE@._V1_.jpg",
    title: "Watch Rise of Empires: Ottoman Season 01 Episode 5 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/74464b31c3fc6c83e84b2fd69803cf0092988dd40bb827799d4ac9602191478ea0aec11f9d4719c7a7937cf6b475c2073716919e21cff16b65160ba1b798084bed15885678dbb53d1f9c96be83d9488d551ef4f94b28480bcc4da8f8f083435a18cc4bbfcbb86b4429f5df40abefb090deb6538fe3654c2eec35fe7bc9a552c32100b155091d38bc85dcd8ef3cd78858/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s01.ep5.srt&title-1=ROE:Ottoman S1 EP5&img=https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p17810281_b_h9_ac.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/74464b31c3fc6c83e84b2fd69803cf0092988dd40bb827799d4ac9602191478ea0aec11f9d4719c7a7937cf6b475c2073716919e21cff16b65160ba1b798084bed15885678dbb53d1f9c96be83d9488d551ef4f94b28480bcc4da8f8f083435a18cc4bbfcbb86b4429f5df40abefb090deb6538fe3654c2eec35fe7bc9a552c32100b155091d38bc85dcd8ef3cd78858/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s01.ep5.srt&title-1=ROE:Ottoman S1 EP5&img=https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p17810281_b_h9_ac.jpg",
});
mapRedirect(["rise-of-empires-ottoman-s1-ep6"], {
    splashimgurl: "https://m.media-amazon.com/images/M/MV5BM2EwZmQxYzYtNzFjNy00YWMxLWE0MTktNjE3ZjZhNTNlN2Q1XkEyXkFqcGdeQXVyOTkzODAxNTE@._V1_.jpg",
    title: "Watch Rise of Empires: Ottoman Season 01 Episode 6 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/2f65a3496de8237a49311b52fe7acb4b0c40134efffd898a4762c0459db7695b0a356c12c1a579115f5e86e56b6ccd03b56696f2e1e341cbfa00b9be18e857894dd6845a13a83078cd40ef1d2e711a3a74e770c6dbfbe5bd415cce148109bba4a57c7182404301617fdc3a9d744a0bbde9fd7c53cfea46ad03e043eeb43b09d7e32d9d5150142748117c34b962e60e9f/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s01.ep6.srt&title-1=ROE:Ottoman S1 EP6&img=https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p17810281_b_h9_ac.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/2f65a3496de8237a49311b52fe7acb4b0c40134efffd898a4762c0459db7695b0a356c12c1a579115f5e86e56b6ccd03b56696f2e1e341cbfa00b9be18e857894dd6845a13a83078cd40ef1d2e711a3a74e770c6dbfbe5bd415cce148109bba4a57c7182404301617fdc3a9d744a0bbde9fd7c53cfea46ad03e043eeb43b09d7e32d9d5150142748117c34b962e60e9f/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s01.ep6.srt&title-1=ROE:Ottoman S1 EP6&img=https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p17810281_b_h9_ac.jpg",
});

//Rise Of Empires: Ottoman Season 02
mapRedirect(["rise-of-empires-ottoman-s2-ep1"], {
    splashimgurl: "https://m.media-amazon.com/images/M/MV5BM2EwZmQxYzYtNzFjNy00YWMxLWE0MTktNjE3ZjZhNTNlN2Q1XkEyXkFqcGdeQXVyOTkzODAxNTE@._V1_.jpg",
    title: "Watch Rise of Empires: Ottoman Season 02 Episode 1 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/3a9db365b7b758613fdf065da0a2704e8d1f50cee0fc335f2cc58b1be0a4ae788c850389bbe481a6603310c0aa954f8774c3392067043cbcc4b853a51f6e5d30299b9db70a93159ee2c3a103b9a5970231b62f18c35cb939731d263020256c24fbf8a7bb2503fe189d76d7b5100d42e0c4c39a0a47ed0f9590ea6e20832b91c80c3f588433b759667f4b019fed2d32ed/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s02.ep1.srt&title-1=ROE:Ottoman S2 EP1&img=https://i.ytimg.com/vi/8u6Q42XJoog/maxresdefault.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/3a9db365b7b758613fdf065da0a2704e8d1f50cee0fc335f2cc58b1be0a4ae788c850389bbe481a6603310c0aa954f8774c3392067043cbcc4b853a51f6e5d30299b9db70a93159ee2c3a103b9a5970231b62f18c35cb939731d263020256c24fbf8a7bb2503fe189d76d7b5100d42e0c4c39a0a47ed0f9590ea6e20832b91c80c3f588433b759667f4b019fed2d32ed/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s02.ep1.srt&title-1=ROE:Ottoman S2 EP1&img=https://i.ytimg.com/vi/8u6Q42XJoog/maxresdefault.jpg",
});
mapRedirect(["rise-of-empires-ottoman-s2-ep2"], {
    splashimgurl: "https://m.media-amazon.com/images/M/MV5BM2EwZmQxYzYtNzFjNy00YWMxLWE0MTktNjE3ZjZhNTNlN2Q1XkEyXkFqcGdeQXVyOTkzODAxNTE@._V1_.jpg",
    title: "Watch Rise of Empires: Ottoman Season 02 Episode 2 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/9290b71de3913cb3cd17ad4c84b4a6006deccea748fc26c7bdd596ad172a75c3b2a8f68af89ce2fc2b3d3000cd9258a7ebc2a912925fe9c483a9fe329ff595a99da3fe918a6603a81d929fc758129b3bc70d63650c46099740cd75caf8c63a4721a325d9a050124e6a723c15234c617439b652221faabdbbb1af18db35597aa7fcfb8e4e8116869ec552ac317c611c57/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s02.ep2.srt&title-1=ROE:Ottoman S2 EP2&img=https://i.ytimg.com/vi/8u6Q42XJoog/maxresdefault.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/9290b71de3913cb3cd17ad4c84b4a6006deccea748fc26c7bdd596ad172a75c3b2a8f68af89ce2fc2b3d3000cd9258a7ebc2a912925fe9c483a9fe329ff595a99da3fe918a6603a81d929fc758129b3bc70d63650c46099740cd75caf8c63a4721a325d9a050124e6a723c15234c617439b652221faabdbbb1af18db35597aa7fcfb8e4e8116869ec552ac317c611c57/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s02.ep2.srt&title-1=ROE:Ottoman S2 EP2&img=https://i.ytimg.com/vi/8u6Q42XJoog/maxresdefault.jpg",
});
mapRedirect(["rise-of-empires-ottoman-s2-ep3"], {
    splashimgurl: "https://m.media-amazon.com/images/M/MV5BM2EwZmQxYzYtNzFjNy00YWMxLWE0MTktNjE3ZjZhNTNlN2Q1XkEyXkFqcGdeQXVyOTkzODAxNTE@._V1_.jpg",
    title: "Watch Rise of Empires: Ottoman Season 02 Episode 3 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/ed8764143c88631d585ddef4c99ccbfa89a76d7a2c942ee90e7bca320e2e28ac0c183daaf31cc1eb4ad08d5a151389c268e64c3e519b4a928992273af504bffd69746fb47d91406a8ed604e7b196b54de1db14e092a10df7fa9269bde8fa8c3da18a9ef9ca20b42119d1248e1ac3707709d301853ea66106477d2e0e3fd8c79b7ca2cf32f6d25fc070d4dc4bfc2b6550/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s02.ep3.srt&title-1=ROE:Ottoman S2 EP3&img=https://i.ytimg.com/vi/8u6Q42XJoog/maxresdefault.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/ed8764143c88631d585ddef4c99ccbfa89a76d7a2c942ee90e7bca320e2e28ac0c183daaf31cc1eb4ad08d5a151389c268e64c3e519b4a928992273af504bffd69746fb47d91406a8ed604e7b196b54de1db14e092a10df7fa9269bde8fa8c3da18a9ef9ca20b42119d1248e1ac3707709d301853ea66106477d2e0e3fd8c79b7ca2cf32f6d25fc070d4dc4bfc2b6550/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s02.ep3.srt&title-1=ROE:Ottoman S2 EP3&img=https://i.ytimg.com/vi/8u6Q42XJoog/maxresdefault.jpg",
});
mapRedirect(["rise-of-empires-ottoman-s2-ep4"], {
    splashimgurl: "https://m.media-amazon.com/images/M/MV5BM2EwZmQxYzYtNzFjNy00YWMxLWE0MTktNjE3ZjZhNTNlN2Q1XkEyXkFqcGdeQXVyOTkzODAxNTE@._V1_.jpg",
    title: "Watch Rise of Empires: Ottoman Season 02 Episode 4 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/6d89502c88dc6c77055c45e60d7b15b79ebc51aabbcca89730b5b56997ce87ef6050dad70d4d54a71225e585e19674637fb99fe65cb8f9b1c3f0308eb37269ae596001f746e7c6e697bedb2d3b64f7303235bf34af781901f79db3d25ff0978c6886c3d040dcb1e4a234cd92c700f55f6afc3e54e2ebfd21ec346165455fd1ed286d57616cc2a2c2d3bb7fc0d0475083/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s02.ep4.srt&title-1=ROE:Ottoman S2 EP4&img=https://i.ytimg.com/vi/8u6Q42XJoog/maxresdefault.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/6d89502c88dc6c77055c45e60d7b15b79ebc51aabbcca89730b5b56997ce87ef6050dad70d4d54a71225e585e19674637fb99fe65cb8f9b1c3f0308eb37269ae596001f746e7c6e697bedb2d3b64f7303235bf34af781901f79db3d25ff0978c6886c3d040dcb1e4a234cd92c700f55f6afc3e54e2ebfd21ec346165455fd1ed286d57616cc2a2c2d3bb7fc0d0475083/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s02.ep4.srt&title-1=ROE:Ottoman S2 EP4&img=https://i.ytimg.com/vi/8u6Q42XJoog/maxresdefault.jpg",
});
mapRedirect(["rise-of-empires-ottoman-s2-ep5"], {
    splashimgurl: "https://m.media-amazon.com/images/M/MV5BM2EwZmQxYzYtNzFjNy00YWMxLWE0MTktNjE3ZjZhNTNlN2Q1XkEyXkFqcGdeQXVyOTkzODAxNTE@._V1_.jpg",
    title: "Watch Rise of Empires: Ottoman Season 02 Episode 5 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/27a962b63be56daf89411f863ef46ee263bcf7c1e3d2779411e3c44dc668e8df5502b69be4d8ea26afdb9476d58744bfac6ba4c84135d70d477ac325f4d6036f45b8eb61f1baea351311dfda35da116f58dd72e89e737bafd1f3a484dfed924731d86b561750f17fce4e00e9cbcd12f536d17a1d909449cde9a5c87ce7c3b6a88fa3bd6c36f251f753f8d778481e1f33/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s02.ep5.srt&title-1=ROE:Ottoman S2 EP5&img=https://i.ytimg.com/vi/8u6Q42XJoog/maxresdefault.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/27a962b63be56daf89411f863ef46ee263bcf7c1e3d2779411e3c44dc668e8df5502b69be4d8ea26afdb9476d58744bfac6ba4c84135d70d477ac325f4d6036f45b8eb61f1baea351311dfda35da116f58dd72e89e737bafd1f3a484dfed924731d86b561750f17fce4e00e9cbcd12f536d17a1d909449cde9a5c87ce7c3b6a88fa3bd6c36f251f753f8d778481e1f33/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s02.ep5.srt&title-1=ROE:Ottoman S2 EP5&img=https://i.ytimg.com/vi/8u6Q42XJoog/maxresdefault.jpg",
});
mapRedirect(["rise-of-empires-ottoman-s2-ep6"], {
    splashimgurl: "https://m.media-amazon.com/images/M/MV5BM2EwZmQxYzYtNzFjNy00YWMxLWE0MTktNjE3ZjZhNTNlN2Q1XkEyXkFqcGdeQXVyOTkzODAxNTE@._V1_.jpg",
    title: "Watch Rise of Empires: Ottoman Season 02 Episode 6 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/d69659fbb6d8f2d2c517344d23e873a5d482dbcb3df7cf562f61b633c47609beb70f25ef699c22d4e3b10ffd5da72549ca37b2af579b3cde177dbdae645b74f8158aaf728b8e49dfb361796c7679f6fdb0baa5a94ba0f4da634ca1350913b4dad60a76f72101cdbbb2049219ed31eb05759df2416b078bd1001ab13ae8dde22a81f5a15463e74da25f2c181da288afd0/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s02.ep6.srt&title-1=ROE:Ottoman S2 EP6&img=https://i.ytimg.com/vi/8u6Q42XJoog/maxresdefault.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/d69659fbb6d8f2d2c517344d23e873a5d482dbcb3df7cf562f61b633c47609beb70f25ef699c22d4e3b10ffd5da72549ca37b2af579b3cde177dbdae645b74f8158aaf728b8e49dfb361796c7679f6fdb0baa5a94ba0f4da634ca1350913b4dad60a76f72101cdbbb2049219ed31eb05759df2416b078bd1001ab13ae8dde22a81f5a15463e74da25f2c181da288afd0/playlist.m3u8&subcode=en&substitleurl=substitles/series/roe/roeo.s02.ep6.srt&title-1=ROE:Ottoman S2 EP6&img=https://i.ytimg.com/vi/8u6Q42XJoog/maxresdefault.jpg",
});

//Man Vs Bee
mapRedirect(["man-vs-bee-s1-ep1"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/coYERmVAA64FYVNa5RgJ3AFyVFv.jpg",
    title: "Watch Man Vs Bee Season 01 Episode 01 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/3029f0231a8b6a0c8a6faf6ae450b2d218e6d7ee17e7688182a32f3d7439846b0f16a2cf4d0021c4254c65fffdbf48b44565846c7e4f60ba77238dc2de4dc91402e18523e407fd9936e072f62e33ba9bcee68ba97feffc668c1afab5695f333df3c1cfc9e1b1d0ab88046044040b7ecfb8c17c99739ed0e06eaf54c93e3f7aa42bd67e14799b822897c489bf6b87264a/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep1.srt&title-1=Man Vs Bee S1 EP1&img=https://image.tmdb.org/t/p/original/zfI9bzBaEYSJhFJS3Ljd31epUEM.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/3029f0231a8b6a0c8a6faf6ae450b2d218e6d7ee17e7688182a32f3d7439846b0f16a2cf4d0021c4254c65fffdbf48b44565846c7e4f60ba77238dc2de4dc91402e18523e407fd9936e072f62e33ba9bcee68ba97feffc668c1afab5695f333df3c1cfc9e1b1d0ab88046044040b7ecfb8c17c99739ed0e06eaf54c93e3f7aa42bd67e14799b822897c489bf6b87264a/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep1.srt&title-1=Man Vs Bee S1 EP1&img=https://image.tmdb.org/t/p/original/zfI9bzBaEYSJhFJS3Ljd31epUEM.jpg",
});
mapRedirect(["man-vs-bee-s1-ep2"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/coYERmVAA64FYVNa5RgJ3AFyVFv.jpg",
    title: "Watch Man Vs Bee Season 01 Episode 02 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/95756293e96e804173e303df578d0a246cca4ffa4fe57a342f318f0b3c061a9bc6dcdd0a7eb72cc773be5dfb90739db2bbd494771acfbaf959cc1945d23cc4b591cb90bf3641828e09e9ebcba5a07d71d1403ee1b4b1b5edfe571145cbd9cc76b68870c9f2fc159a3fa5801c8f06a4b4cc80cc05e7eb2d0c83e0f03c73ac90b64cd66a0dc6f886a89c0fba82d11ac447/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep2.srt&title-1=Man Vs Bee S1 EP2&img=https://image.tmdb.org/t/p/original/dGCrZnXCOrxXJKNTK2hMqwvifm5.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/95756293e96e804173e303df578d0a246cca4ffa4fe57a342f318f0b3c061a9bc6dcdd0a7eb72cc773be5dfb90739db2bbd494771acfbaf959cc1945d23cc4b591cb90bf3641828e09e9ebcba5a07d71d1403ee1b4b1b5edfe571145cbd9cc76b68870c9f2fc159a3fa5801c8f06a4b4cc80cc05e7eb2d0c83e0f03c73ac90b64cd66a0dc6f886a89c0fba82d11ac447/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep2.srt&title-1=Man Vs Bee S1 EP2&img=https://image.tmdb.org/t/p/original/dGCrZnXCOrxXJKNTK2hMqwvifm5.jpg",
});
mapRedirect(["man-vs-bee-s1-ep3"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/coYERmVAA64FYVNa5RgJ3AFyVFv.jpg",
    title: "Watch Man Vs Bee Season 01 Episode 03 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/d504c32098192c89ecbc4902d74f18cd5b13fc2b370078c6c385a01ac1efbdc1d35f908b5017934b436c7daf2d8d44180ece79fbe1df0033b34cc87ae02192f66f3295992a47a100eb369da7b29f174798a41b4f35740f9097740295db94d03edfd5c5b81b8dc1fb5c262342cae3725a0d9defbe1ed20b355bcd5bb2e1d45d48fc9f9d4e403a3c4012d873b14860ed90/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep3.srt&title-1=Man Vs Bee S1 EP3&img=https://image.tmdb.org/t/p/original/oFm97FvIcVJqnhHgciUKhuP4xzn.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/d504c32098192c89ecbc4902d74f18cd5b13fc2b370078c6c385a01ac1efbdc1d35f908b5017934b436c7daf2d8d44180ece79fbe1df0033b34cc87ae02192f66f3295992a47a100eb369da7b29f174798a41b4f35740f9097740295db94d03edfd5c5b81b8dc1fb5c262342cae3725a0d9defbe1ed20b355bcd5bb2e1d45d48fc9f9d4e403a3c4012d873b14860ed90/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep3.srt&title-1=Man Vs Bee S1 EP3&img=https://image.tmdb.org/t/p/original/oFm97FvIcVJqnhHgciUKhuP4xzn.jpg",
});
mapRedirect(["man-vs-bee-s1-ep4"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/coYERmVAA64FYVNa5RgJ3AFyVFv.jpg",
    title: "Watch Man Vs Bee Season 01 Episode 04 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/e03fd524afcc1b09f8752f550bf14dfc61bb03ee67a37854606a07e0a1fa3fff47ec58cff650599c34cfeb91bd11966cb75c19a895df989305b60aa6efa20d67e8b74578b77d87b9c1b87bd0fffb36b97c4245d620df12a23e3220989e88b7ed472e4f377b39090934898484b4a91d5f61f8f054f3a14c3870d21ea7283119951653ed82058fc880878dabf105edcf6e/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep4.srt&title-1=Man Vs Bee S1 EP4&img=https://image.tmdb.org/t/p/original/zfI9bzBaEYSJhFJS3Ljd31epUEM.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/e03fd524afcc1b09f8752f550bf14dfc61bb03ee67a37854606a07e0a1fa3fff47ec58cff650599c34cfeb91bd11966cb75c19a895df989305b60aa6efa20d67e8b74578b77d87b9c1b87bd0fffb36b97c4245d620df12a23e3220989e88b7ed472e4f377b39090934898484b4a91d5f61f8f054f3a14c3870d21ea7283119951653ed82058fc880878dabf105edcf6e/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep4.srt&title-1=Man Vs Bee S1 EP4&img=https://image.tmdb.org/t/p/original/zfI9bzBaEYSJhFJS3Ljd31epUEM.jpg",
});
mapRedirect(["man-vs-bee-s1-ep5"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/coYERmVAA64FYVNa5RgJ3AFyVFv.jpg",
    title: "Watch Man Vs Bee Season 01 Episode 05 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/9302b001576b0bb92b52205a2ec0857601d77dcbba4eb3e0fb2292fcf0b573056f52fec41ca75ba87827e65577350de01900253548ae5be139792da3a4585343d5a575f1eae2d814a9cb8bef9e02dd2bddc1155a0b2e8c6bab9b781657eb3604bc7789cf1d6e79c59f3437402e943878c60f0429d5aa6e9618cad56e32db4728c15b09efa40fa312567faca270c89a14/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep5.srt&title-1=Man Vs Bee S1 EP5&img=https://image.tmdb.org/t/p/original/dGCrZnXCOrxXJKNTK2hMqwvifm5.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/9302b001576b0bb92b52205a2ec0857601d77dcbba4eb3e0fb2292fcf0b573056f52fec41ca75ba87827e65577350de01900253548ae5be139792da3a4585343d5a575f1eae2d814a9cb8bef9e02dd2bddc1155a0b2e8c6bab9b781657eb3604bc7789cf1d6e79c59f3437402e943878c60f0429d5aa6e9618cad56e32db4728c15b09efa40fa312567faca270c89a14/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep5.srt&title-1=Man Vs Bee S1 EP5&img=https://image.tmdb.org/t/p/original/dGCrZnXCOrxXJKNTK2hMqwvifm5.jpg",
});
mapRedirect(["man-vs-bee-s1-ep6"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/coYERmVAA64FYVNa5RgJ3AFyVFv.jpg",
    title: "Watch Man Vs Bee Season 01 Episode 06 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/806e58d71117205f9ec72fb1c69f79f4d5d0449f0dd6c57368fedd415a8940bced2f320cfd1acb5ee36fe62251f62e6236b7fce63a8bf991c7af24964034b85be79ae354be539bc160e8d86be924000ac9b22506799befe17fb7d903cb3eaef3df2ea57a6f8c5bf004b450775cce943f1c7f321de900f91959883cca65321c1642c15062fe40a4674d4447bb7bb5ed95/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep6.srt&title-1=Man Vs Bee S1 EP6&img=https://image.tmdb.org/t/p/original/oFm97FvIcVJqnhHgciUKhuP4xzn.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/806e58d71117205f9ec72fb1c69f79f4d5d0449f0dd6c57368fedd415a8940bced2f320cfd1acb5ee36fe62251f62e6236b7fce63a8bf991c7af24964034b85be79ae354be539bc160e8d86be924000ac9b22506799befe17fb7d903cb3eaef3df2ea57a6f8c5bf004b450775cce943f1c7f321de900f91959883cca65321c1642c15062fe40a4674d4447bb7bb5ed95/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep6.srt&title-1=Man Vs Bee S1 EP6&img=https://image.tmdb.org/t/p/original/oFm97FvIcVJqnhHgciUKhuP4xzn.jpg",
});
mapRedirect(["man-vs-bee-s1-ep7"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/coYERmVAA64FYVNa5RgJ3AFyVFv.jpg",
    title: "Watch Man Vs Bee Season 01 Episode 07 With English Subtitle",
    video: "series.html?source=https://i.polllfmovlop.com/_v11/3a8e00cba67744643d35016704263429e707ed601231b131de810443eff769ad76925fb7ebc8559ca2e7044f16bad048f08258013ae8bda8f6a2782a98492229898531b542835f2a2b175ede20b303d085ce0cfff9436a31747d03d2d65557d880504b64bef496d3ac666beaf9396578829db950ea5780be2efb5ddc2b7fbc1d5a78b2ef194bc1c5d1c248cbe5f40cff/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep7.srt&title-1=Man Vs Bee S1 EP7&img=https://image.tmdb.org/t/p/original/zfI9bzBaEYSJhFJS3Ljd31epUEM.jpg",
    video2: "series2.html?source=https://i.polllfmovlop.com/_v11/3a8e00cba67744643d35016704263429e707ed601231b131de810443eff769ad76925fb7ebc8559ca2e7044f16bad048f08258013ae8bda8f6a2782a98492229898531b542835f2a2b175ede20b303d085ce0cfff9436a31747d03d2d65557d880504b64bef496d3ac666beaf9396578829db950ea5780be2efb5ddc2b7fbc1d5a78b2ef194bc1c5d1c248cbe5f40cff/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep7.srt&title-1=Man Vs Bee S1 EP7&img=https://image.tmdb.org/t/p/original/zfI9bzBaEYSJhFJS3Ljd31epUEM.jpg",
});
mapRedirect(["man-vs-bee-s1-ep8"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/coYERmVAA64FYVNa5RgJ3AFyVFv.jpg",
    title: "Watch Man Vs Bee Season 01 Episode 08 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/ee6dc9a2b525d50c80fe5679b0099a319497148dc6c4f6ec0c8893c9b6dfd878f02c817a7ff9fc80cc1ada0e2ad45f6cf32bf5b1f7cb06dd8bc288bc49cf0519fd8fdaaa5bd626ea3e2649d287a5d2544c35dbe7b4bb3a152287c9489f3c902a0c372afcc87eb4a32c3f2f27e127dadf6e31c599ba39b1c8fdc26512dfa507718be2bac059b564e5601f5f5f359beade/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep8.srt&title-1=Man Vs Bee S1 EP8&img=https://image.tmdb.org/t/p/original/dGCrZnXCOrxXJKNTK2hMqwvifm5.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/ee6dc9a2b525d50c80fe5679b0099a319497148dc6c4f6ec0c8893c9b6dfd878f02c817a7ff9fc80cc1ada0e2ad45f6cf32bf5b1f7cb06dd8bc288bc49cf0519fd8fdaaa5bd626ea3e2649d287a5d2544c35dbe7b4bb3a152287c9489f3c902a0c372afcc87eb4a32c3f2f27e127dadf6e31c599ba39b1c8fdc26512dfa507718be2bac059b564e5601f5f5f359beade/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep8.srt&title-1=Man Vs Bee S1 EP8&img=https://image.tmdb.org/t/p/original/dGCrZnXCOrxXJKNTK2hMqwvifm5.jpg",
});
mapRedirect(["man-vs-bee-s1-ep9"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/coYERmVAA64FYVNa5RgJ3AFyVFv.jpg",
    title: "Watch Man Vs Bee Season 01 Episode 09 With English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/3b9df7aff183e66e1e7f7b376b5287d700fe9ed02eaaaa6d949ca41736caf792bb839e9cd7981a90be48425c94daa0680903ff6225e7843d3a5eae1e64dc80e65141036fa57f9439d65e06dd9f9cce2f63ef19ec5e40b3ca7162fe76d9463fa0aa193a0b460ecd9708ee0e9d6467a1b5e8927b7ee4dc590407d7952d69b80c9fbcba7b7a60034a638cb4d6183163c65d/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep9.srt&title-1=Man Vs Bee S1 EP9&img=https://image.tmdb.org/t/p/original/oFm97FvIcVJqnhHgciUKhuP4xzn.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/3b9df7aff183e66e1e7f7b376b5287d700fe9ed02eaaaa6d949ca41736caf792bb839e9cd7981a90be48425c94daa0680903ff6225e7843d3a5eae1e64dc80e65141036fa57f9439d65e06dd9f9cce2f63ef19ec5e40b3ca7162fe76d9463fa0aa193a0b460ecd9708ee0e9d6467a1b5e8927b7ee4dc590407d7952d69b80c9fbcba7b7a60034a638cb4d6183163c65d/playlist.m3u8&subcode=en&substitleurl=substitles/series/man-vs-bee/man-vs-bee-s1-ep9.srt&title-1=Man Vs Bee S1 EP9&img=https://image.tmdb.org/t/p/original/oFm97FvIcVJqnhHgciUKhuP4xzn.jpg",
});
//Mirzapur Season 01
mapRedirect(["mirzapur-s1-ep1", "1621276"], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 01 Episode 01",
    video: "series.html?source=https://ai.bigtimedelivery.net/_v13/c200233762081f06a7f110cbd9c7616b8dab40bebb7be58fd3be8af627f6eacc8cd70eaaeb4e87f6b5732afa10e481c97fc473f7538e4adae0055cdcb54d3d097e3d5bd0dcabc7a2704bb757a5228157ca095ed00397cc0494b71ae5c7cac1571cc685fa3755865629e710248ec5c9e1e6dd515918149200640326a3c27d9bc297696604f593c3f96f99f2badea71c0d/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP01&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    video2: "series2.html?source=https://ai.bigtimedelivery.net/_v13/c200233762081f06a7f110cbd9c7616b8dab40bebb7be58fd3be8af627f6eacc8cd70eaaeb4e87f6b5732afa10e481c97fc473f7538e4adae0055cdcb54d3d097e3d5bd0dcabc7a2704bb757a5228157ca095ed00397cc0494b71ae5c7cac1571cc685fa3755865629e710248ec5c9e1e6dd515918149200640326a3c27d9bc297696604f593c3f96f99f2badea71c0d/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP01&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s1-ep2", "1621280"], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 01 Episode 02",
    video: "series.html?source=https://ag.bigtimedelivery.net/_v13/d48c62cca20bd9a69a84d1f61ac3e64697cf504257e0c529232a6f0df709d943ea9752bc8573b78937fcf8093ad2abe5f766e1ed33c46b0743f0c4541c0f360691198bf733eb29d8fed50770634285724ba1e41be677e1bb665e620a4f78aad69191069a2bec496fb86ad36b6efb99fc7e5ee309d31ef42406879970fd3082c93d353e71e422cb99fbb1793dca46490e/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP02&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    video2: "series2.html?source=https://ag.bigtimedelivery.net/_v13/d48c62cca20bd9a69a84d1f61ac3e64697cf504257e0c529232a6f0df709d943ea9752bc8573b78937fcf8093ad2abe5f766e1ed33c46b0743f0c4541c0f360691198bf733eb29d8fed50770634285724ba1e41be677e1bb665e620a4f78aad69191069a2bec496fb86ad36b6efb99fc7e5ee309d31ef42406879970fd3082c93d353e71e422cb99fbb1793dca46490e/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP02&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s1-ep3", "1621281"], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 01 Episode 03",
    video: "series.html?source=https://aa.bigtimedelivery.net/_v13/ea29991996a6703d5db327424427e2cece98aa4e2ed2c220aed93dce397dd85592f7fad03c0fa8e8d7987d8f90a09d0593f2be58cba148f068617fa98290646522de714e8dcae6890602c83ccb0c3f782acc6de82e22a7d43b1d201fe6c24681e1fc4f61b8410fad7b087bae23a6de08485aed315c58692244a681cc31631ce76b58257ef808e53e2a7307e3e645d4d9/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP03&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/ea29991996a6703d5db327424427e2cece98aa4e2ed2c220aed93dce397dd85592f7fad03c0fa8e8d7987d8f90a09d0593f2be58cba148f068617fa98290646522de714e8dcae6890602c83ccb0c3f782acc6de82e22a7d43b1d201fe6c24681e1fc4f61b8410fad7b087bae23a6de08485aed315c58692244a681cc31631ce76b58257ef808e53e2a7307e3e645d4d9/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP03&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s1-ep4", "1621282"], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 01 Episode 04",
    video: "series.html?source=https://ai.bigtimedelivery.net/_v13/e86e1ba400b232b86817e019f18c9c4210791729e63da6a6d63f09e9e48e82dbc13090c18ef604198e9b2dc0ba188a6bc072b73bbcdbe782573cb62ebd1583dd55a48df1c301225fa1ce72a9aefbf5120a9a42d6f6875a415960bbf17bdb90663f7eb90098772737bd536835ae1a78b7a8f5fb4df99f258f6def7f724aff56bdff88c546517cd0357801352ce91e8984/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP04&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    video2: "series2.html?source=https://ai.bigtimedelivery.net/_v13/e86e1ba400b232b86817e019f18c9c4210791729e63da6a6d63f09e9e48e82dbc13090c18ef604198e9b2dc0ba188a6bc072b73bbcdbe782573cb62ebd1583dd55a48df1c301225fa1ce72a9aefbf5120a9a42d6f6875a415960bbf17bdb90663f7eb90098772737bd536835ae1a78b7a8f5fb4df99f258f6def7f724aff56bdff88c546517cd0357801352ce91e8984/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP04&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s1-ep5", "1621284"], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 01 Episode 05",
    video: "series.html?source=https://ab.bigtimedelivery.net/_v13/ba2fe7b0ba3a8a4cc238c2f00241a8ba7e4d7cbf93beaa46fe6510406a7e711b754b84438497f5518caa1888d2d60aa37f18ea75527ea6fd8ad4fb43a1d9dc73ad7ec32e69f24748c863ba6b9d9b9d3279562f7f577672da4dfa2981ee1b45056f49cef99532e65b99f987490b0dde15c96a9fba5b84cdac0412479c412c91222faec17fa38abd8564c9f57b947b6ae4/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP05&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/ba2fe7b0ba3a8a4cc238c2f00241a8ba7e4d7cbf93beaa46fe6510406a7e711b754b84438497f5518caa1888d2d60aa37f18ea75527ea6fd8ad4fb43a1d9dc73ad7ec32e69f24748c863ba6b9d9b9d3279562f7f577672da4dfa2981ee1b45056f49cef99532e65b99f987490b0dde15c96a9fba5b84cdac0412479c412c91222faec17fa38abd8564c9f57b947b6ae4/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP05&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s1-ep6", ""], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 01 Episode 06",
    video: "series.html?source=https://ab.bigtimedelivery.net/_v13/f951d4468d8e5004825b804819bb3ac1afb90395b690169a8b73b01317c083d8ca48b409a3fbd23666ba1112569aeb60fe5b3438ecf265360873e97d4efa63f580dbb062293f3541a6e22cd9ba873d29adb9ccceafaac3d024f2fde67ae7146ade07fac56d5f2fd9a00653da41c64ffdf8814bb1c3dcaf867dd85614f54fb6d4e036f5ed062174e0566dc7cff25638f1/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP06&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/f951d4468d8e5004825b804819bb3ac1afb90395b690169a8b73b01317c083d8ca48b409a3fbd23666ba1112569aeb60fe5b3438ecf265360873e97d4efa63f580dbb062293f3541a6e22cd9ba873d29adb9ccceafaac3d024f2fde67ae7146ade07fac56d5f2fd9a00653da41c64ffdf8814bb1c3dcaf867dd85614f54fb6d4e036f5ed062174e0566dc7cff25638f1/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP06&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s1-ep7", ""], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 01 Episode 07",
    video: "series.html?source=https://ab.bigtimedelivery.net/_v13/46ab7a2e0009ef394b49870c14533b54f78733005893c6f44f3b73b0397e2771e25a514276df02daedbef4348bb8ead2ab9b3a0c9d404dd21c8f6b69ec86afc2be3ebcef727b24e8a261cab03c172483f9a16856c779d4d04726dc786169930a0f6f18a52a7a714fac6b80b8241ce3361b8c33330ce7133a59d9326dab0c9d8139cdb24bd08e7789b982c426eb6521fa/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP07&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/46ab7a2e0009ef394b49870c14533b54f78733005893c6f44f3b73b0397e2771e25a514276df02daedbef4348bb8ead2ab9b3a0c9d404dd21c8f6b69ec86afc2be3ebcef727b24e8a261cab03c172483f9a16856c779d4d04726dc786169930a0f6f18a52a7a714fac6b80b8241ce3361b8c33330ce7133a59d9326dab0c9d8139cdb24bd08e7789b982c426eb6521fa/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP07&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s1-ep8", ""], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 01 Episode 08",
    video: "series.html?source=https://ag.bigtimedelivery.net/_v13/89ef8c6ee979882603ff9b6c582a2ab7a529a00f0efe37f2041100d48616b674b0d96b4f347f246db0ecc9a184f8b53d1c2a611bc068ad605795d90ceb5a4845e1675a1c5f2c411c8017a98380ec2a080db5b6a5fe8179a916b453a7e8d1eb039a46a757e2e1da3066b55d2a348ccc84b8f2da7cfb494cc31dff89c8667ca341150d5eab3bedf496ccaf5854d4f4f1ae/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP08&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    video2: "series2.html?source=https://ag.bigtimedelivery.net/_v13/89ef8c6ee979882603ff9b6c582a2ab7a529a00f0efe37f2041100d48616b674b0d96b4f347f246db0ecc9a184f8b53d1c2a611bc068ad605795d90ceb5a4845e1675a1c5f2c411c8017a98380ec2a080db5b6a5fe8179a916b453a7e8d1eb039a46a757e2e1da3066b55d2a348ccc84b8f2da7cfb494cc31dff89c8667ca341150d5eab3bedf496ccaf5854d4f4f1ae/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP08&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s1-ep9", ""], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 01 Episode 09",
    video: "series.html?source=https://af.bigtimedelivery.net/_v13/c565cb03db7179e98a05c0415551261a25037c0a69cfd27a45207f921c6cc5ca7048cd4c6fa3045946471d57ace85dc766736514259500dfc5a295e359cf094b61b12f2d0f49b178b925ab01c712297e3e60730980875440f2d5ca34fb66ace41a583ccb7b7012105843868370f05c8587da905c4df288acf3cb0fe94fa4a7e929d05d0b946b216842f0c2ff5acc933b/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP09&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/c565cb03db7179e98a05c0415551261a25037c0a69cfd27a45207f921c6cc5ca7048cd4c6fa3045946471d57ace85dc766736514259500dfc5a295e359cf094b61b12f2d0f49b178b925ab01c712297e3e60730980875440f2d5ca34fb66ace41a583ccb7b7012105843868370f05c8587da905c4df288acf3cb0fe94fa4a7e929d05d0b946b216842f0c2ff5acc933b/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S01%20EP09&img=https://m.media-amazon.com/images/S/pv-target-images/96a00698329270009f7f4c9605ef8efb612a9ee867d0451badbb9a6441ebe6b3._SX1080_FMjpg_.jpg",
    para: "Please be patient while the video loads.",
});

//Mirzapur Season 02
mapRedirect(["mirzapur-s2-ep1", ""], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 02 Episode 01",
    video: "series.html?source=https://ah.bigtimedelivery.net/_v13/52e9b2e98048dea2b6c4dd328fee4a34a79f3ee6680be260aa9e37c54b545ad4a97801acfc755e5783c18eb083832dbd2ff5cdfe5ad7da57b856e543308fd305abc1d31dbfa25b7015d8dce6369f70987205b21bbedeea675222fd491b450d6a51b7c4c27b63103abd5f92775ec4dcf0e7cabf6bb9507b191ac74d8d21475abfbb68533e57c782a0aec832e4605beb7a/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep1&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    video2: "series2.html?source=https://ah.bigtimedelivery.net/_v13/52e9b2e98048dea2b6c4dd328fee4a34a79f3ee6680be260aa9e37c54b545ad4a97801acfc755e5783c18eb083832dbd2ff5cdfe5ad7da57b856e543308fd305abc1d31dbfa25b7015d8dce6369f70987205b21bbedeea675222fd491b450d6a51b7c4c27b63103abd5f92775ec4dcf0e7cabf6bb9507b191ac74d8d21475abfbb68533e57c782a0aec832e4605beb7a/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep1&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s2-ep2", ""], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 02 Episode 02",
    video: "series.html?source=https://ac.bigtimedelivery.net/_v13/694c9fd4fb9b687f0fc0e34c31a0677e21ba5dbb362deb037b78eb73a17e034ece06ad17f8149416da3f6aa3d360510ef4aaf7d80d409c50c65c7cda59ff93ff3548532d8658e6edeb6a6801ea9db6d95ad78d29489831ee97634ce52cc4f70552d16f083c74a7af5be2e490ea36b860351adf9df1950f2982db6456a7514680d3d3734ab06f345ca65c02a371348219/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep2&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    video2: "series2.html?source=https://ac.bigtimedelivery.net/_v13/694c9fd4fb9b687f0fc0e34c31a0677e21ba5dbb362deb037b78eb73a17e034ece06ad17f8149416da3f6aa3d360510ef4aaf7d80d409c50c65c7cda59ff93ff3548532d8658e6edeb6a6801ea9db6d95ad78d29489831ee97634ce52cc4f70552d16f083c74a7af5be2e490ea36b860351adf9df1950f2982db6456a7514680d3d3734ab06f345ca65c02a371348219/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep2&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s2-ep3", ""], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 02 Episode 03",
    video: "series.html?source=https://aj.bigtimedelivery.net/_v13/0c7347fb1c8b520c8af77909ad7c801b5e91bee6ae4aa97d8700f7ed47f8076c682e155759245ae6833500e2aed72cb1e823400a9a03af7c253dae7475082300879334e0aec7080826f4e5f81bc3b5fa81e84d4d6c9cb2f3b87015414d4bfec9b31dbd023cfd0ffcee0e91928c1bd542bb24e1f850b0e7618e0225ec5ef48659027320b33b80fb1a19ebf97fc436ff19/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep3&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/0c7347fb1c8b520c8af77909ad7c801b5e91bee6ae4aa97d8700f7ed47f8076c682e155759245ae6833500e2aed72cb1e823400a9a03af7c253dae7475082300879334e0aec7080826f4e5f81bc3b5fa81e84d4d6c9cb2f3b87015414d4bfec9b31dbd023cfd0ffcee0e91928c1bd542bb24e1f850b0e7618e0225ec5ef48659027320b33b80fb1a19ebf97fc436ff19/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep3&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s2-ep4", ""], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 02 Episode 04",
    video: "series.html?source=https://aa.bigtimedelivery.net/_v13/e08dd8ffeec05a1fea4473ea2cfa2bea5e38ec5d75ea13ebe9c7774f117ae90172acb4b3fe377cc389b38cc09c121b62f12388a21ab60650e764cf2303ba75fefe522a8fc57ce81e24ef21114e706fab7f05fd8aebad759573610c654663fc18f6dfdece113ea17c56b9d37511739fdb197dff948d0536f43588abdd504eb0d913d8444be744c382c4c3bf08d704f6bc/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep4&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/e08dd8ffeec05a1fea4473ea2cfa2bea5e38ec5d75ea13ebe9c7774f117ae90172acb4b3fe377cc389b38cc09c121b62f12388a21ab60650e764cf2303ba75fefe522a8fc57ce81e24ef21114e706fab7f05fd8aebad759573610c654663fc18f6dfdece113ea17c56b9d37511739fdb197dff948d0536f43588abdd504eb0d913d8444be744c382c4c3bf08d704f6bc/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep4&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s2-ep5", ""], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 02 Episode 05",
    video: "series.html?source=https://ac.bigtimedelivery.net/_v13/01d851e51e4261005bc201106d587279d0a4e7a404c6bbd7197f661b901336119d83df84517b12e67dd22daf0fc682808d637239e61c241e4f0f3f1bde667427ce3dafa062e109e9f0ba2a6bd8a796f5bcb57739be2425305ab7fcd87e8bda161fa49df12354041c3bb8a778728459b23d79fdfca87e3d7f27e684743525ce46ad98fa9d9ea63b9de465dce4448333fd/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep5&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    video2: "series2.html?source=https://ac.bigtimedelivery.net/_v13/01d851e51e4261005bc201106d587279d0a4e7a404c6bbd7197f661b901336119d83df84517b12e67dd22daf0fc682808d637239e61c241e4f0f3f1bde667427ce3dafa062e109e9f0ba2a6bd8a796f5bcb57739be2425305ab7fcd87e8bda161fa49df12354041c3bb8a778728459b23d79fdfca87e3d7f27e684743525ce46ad98fa9d9ea63b9de465dce4448333fd/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep5&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s2-ep6", ""], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 02 Episode 06",
    video: "series.html?source=https://ai.bigtimedelivery.net/_v13/56eaf86b38db2eb3a796756aec8855d5dcd0c31b85f67f00963739b1d722e8e6560897e6c687067ccc9b41f0e21ec962737512a5cffc93a299a140c59790d2d7b2749aa380a8b9f80d6f49be87d21c05eb06ac0d89dfa24a72973b985ee68a8140bd0e5efa4d248a274f1d00e4237e54d68549c4dd2e338a56a1f7068786e7659b14e4fce5acd6d41ce16649f8a3ab31/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep6&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    video2: "series2.html?source=https://ai.bigtimedelivery.net/_v13/56eaf86b38db2eb3a796756aec8855d5dcd0c31b85f67f00963739b1d722e8e6560897e6c687067ccc9b41f0e21ec962737512a5cffc93a299a140c59790d2d7b2749aa380a8b9f80d6f49be87d21c05eb06ac0d89dfa24a72973b985ee68a8140bd0e5efa4d248a274f1d00e4237e54d68549c4dd2e338a56a1f7068786e7659b14e4fce5acd6d41ce16649f8a3ab31/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep6&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s2-ep7", ""], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 02 Episode 07",
    video: "series.html?source=https://aj.bigtimedelivery.net/_v13/09cdd9626e0221ae4acb192cda3c19480a57a3ccf66268b943f27c21af7ab5a4929bb9b8f06e9fddd73da3d2365730b64ba3c692c7c2caacbac9376e3d3d6e6cba9825cd85dfea149ece9f6fe12a4fdc175014717dcac8d279991ae8660654aa77146a8c249541c2df17e1423ebf39430e96d406b83c7fbf1e1e84b7b2a10c086924fe479d1ed6f55698801c38482c3e/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep7&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/09cdd9626e0221ae4acb192cda3c19480a57a3ccf66268b943f27c21af7ab5a4929bb9b8f06e9fddd73da3d2365730b64ba3c692c7c2caacbac9376e3d3d6e6cba9825cd85dfea149ece9f6fe12a4fdc175014717dcac8d279991ae8660654aa77146a8c249541c2df17e1423ebf39430e96d406b83c7fbf1e1e84b7b2a10c086924fe479d1ed6f55698801c38482c3e/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep7&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s2-ep8", ""], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 02 Episode 08",
    video: "series.html?source=https://ae.bigtimedelivery.net/_v13/6696ac69a11f2ab321b9cecdf3be6c53d88664c48faa0a50fc0fa28df2a8fddc62d02760a09e2b96888f7fc14f85525a406e714657479db29dfa979ea9553939eee5f73f139b98ec3d81a4dee6a761346b6bdefd03d371a680bbd13de9f89b50be2a335579f08e5237073cb21d4094a11552415dbb9ec428b51390bbf22de9b9e083ac69f0183893b65152960e15e25b/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep8&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    video2: "series2.html?source=https://ae.bigtimedelivery.net/_v13/6696ac69a11f2ab321b9cecdf3be6c53d88664c48faa0a50fc0fa28df2a8fddc62d02760a09e2b96888f7fc14f85525a406e714657479db29dfa979ea9553939eee5f73f139b98ec3d81a4dee6a761346b6bdefd03d371a680bbd13de9f89b50be2a335579f08e5237073cb21d4094a11552415dbb9ec428b51390bbf22de9b9e083ac69f0183893b65152960e15e25b/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep8&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s2-ep9", ""], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 02 Episode 09",
    video: "series.html?source=https://af.bigtimedelivery.net/_v13/238604eae6924429ebe875a34b96d8c5b2dc0b7229e7a6638b99a4fa18c0eb129876da03a8cfb3b6e4ff50b6a50175f285c9ea6b644b9432a7724f121bfd7d655da8cfb80980c68bd823701ca95b1dfadbfb96e3f979278e356e01e824922ae1555e7ab719a2e858c7a1bc7356c9c97ba66003058851c436909619b9e5928bd3f6194831e29ae54216b11b789f98b913/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep9&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/238604eae6924429ebe875a34b96d8c5b2dc0b7229e7a6638b99a4fa18c0eb129876da03a8cfb3b6e4ff50b6a50175f285c9ea6b644b9432a7724f121bfd7d655da8cfb80980c68bd823701ca95b1dfadbfb96e3f979278e356e01e824922ae1555e7ab719a2e858c7a1bc7356c9c97ba66003058851c436909619b9e5928bd3f6194831e29ae54216b11b789f98b913/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep9&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s2-ep10", ""], {
    splashimgurl: "https://diaryofaninsanewriter.files.wordpress.com/2020/10/mirzapur-season-2-review-1.jpg",
    title: "Watch Mirzapur Season 02 Episode 10",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/4da11c17ea037656aa524873dc0b48559b313a0e8b058837d96b1d4e4042ff16f47c6fbe856c36c111746cf3b86906de81ef4a824666fb6789b826c1915953a2e901f97c757acdf4afdd045ab1db86287940d69acb6ba0459720f39dd384c6a6276118384acce39ddc42fc0aa85c904e9f5e5bc3c51d59152c938d2b3b138bd76066b62ed51befa3d51b2b86fca1d0aa/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep10&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/4da11c17ea037656aa524873dc0b48559b313a0e8b058837d96b1d4e4042ff16f47c6fbe856c36c111746cf3b86906de81ef4a824666fb6789b826c1915953a2e901f97c757acdf4afdd045ab1db86287940d69acb6ba0459720f39dd384c6a6276118384acce39ddc42fc0aa85c904e9f5e5bc3c51d59152c938d2b3b138bd76066b62ed51befa3d51b2b86fca1d0aa/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S02%20Ep10&img=https://thecommonmanspeaks.com/wp-content/uploads/2020/10/Mirzapur-2.jpg",
    para: "Please be patient while the video loads.",
});

//Mirzapur Season 03
mapRedirect(["mirzapur-s3-ep1", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/gR33y5RTQbuIRXlRYLAUTWta3PK.jpg",
    title: "Watch Mirzapur Season 03 Episode 01",
    video: "series.html?source=https://ai.bigtimedelivery.net/_v13/20c523e6fc0bcb0b91fa9af138bd5ded7d40935c877227b857ad8e98aadbbd5aa7d0c578353bb665b335e6e832742b681af334ef4fcaf38533ef33aa326a0212b0c9b82bf241c2f569e9ca77458e6258568295fd71ff441735f362a7884416882babc02c127396b8c96e1b5ffb75aa4dd58412149840cb63ec7458657eea1f8b/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep1&img=https://media.themoviedb.org/t/p/original/r64q0CCltNbCiGPtBJuSRkfsZgg.jpg",
    video2: "series2.html?source=https://ai.bigtimedelivery.net/_v13/20c523e6fc0bcb0b91fa9af138bd5ded7d40935c877227b857ad8e98aadbbd5aa7d0c578353bb665b335e6e832742b681af334ef4fcaf38533ef33aa326a0212b0c9b82bf241c2f569e9ca77458e6258568295fd71ff441735f362a7884416882babc02c127396b8c96e1b5ffb75aa4dd58412149840cb63ec7458657eea1f8b/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep1&img=https://media.themoviedb.org/t/p/original/r64q0CCltNbCiGPtBJuSRkfsZgg.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s3-ep2", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/gR33y5RTQbuIRXlRYLAUTWta3PK.jpg",
    title: "Watch Mirzapur Season 03 Episode 02",
    video: "series.html?source=https://ah.bigtimedelivery.net/_v13/0af98e8477a76cf6b787c1325da27714e594ce75ef3f138fb71bcf848cb5e5d2566369b593e60a3fd82e206ed27a5931ba1b0fb9084c32921be24602c221a8bd7bc7c2f01c14a1e5848d76cc16807b26c20b70ac786b9b1fbf5b94be215cd12fb91a5db35610b6675734ab475937f5699db752f670a3e8b705b5e953bfdd7d11/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep2&img=https://media.themoviedb.org/t/p/original/Q0DvQtINXgcDbCY6bXqYgUP6Sa.jpg",
    video2: "series2.html?source=https://ah.bigtimedelivery.net/_v13/0af98e8477a76cf6b787c1325da27714e594ce75ef3f138fb71bcf848cb5e5d2566369b593e60a3fd82e206ed27a5931ba1b0fb9084c32921be24602c221a8bd7bc7c2f01c14a1e5848d76cc16807b26c20b70ac786b9b1fbf5b94be215cd12fb91a5db35610b6675734ab475937f5699db752f670a3e8b705b5e953bfdd7d11/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep2&img=https://media.themoviedb.org/t/p/original/Q0DvQtINXgcDbCY6bXqYgUP6Sa.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s3-ep3", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/gR33y5RTQbuIRXlRYLAUTWta3PK.jpg",
    title: "Watch Mirzapur Season 03 Episode 03",
    video: "series.html?source=https://af.bigtimedelivery.net/_v13/6a7628348d00dd647daa533dcd13b4e47b5af4a9b6503f434403085c0a7bb80debd40a4f954f74c8a762e9b60d68253e012a38145cd744704d1afc90694d3c0a7cd1f43065b56437ab6ecb5bbcdab8e2e1ed3420579aaff9db18ef2b0b393f92b8ba5880a7a723e76bced4400837e7c7bd033681575d484687bfbbaf1b24a685/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep3&img=https://media.themoviedb.org/t/p/original/9670IbjdSU1ZJL0kjccHIRRwbKX.jpg",
    video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/6a7628348d00dd647daa533dcd13b4e47b5af4a9b6503f434403085c0a7bb80debd40a4f954f74c8a762e9b60d68253e012a38145cd744704d1afc90694d3c0a7cd1f43065b56437ab6ecb5bbcdab8e2e1ed3420579aaff9db18ef2b0b393f92b8ba5880a7a723e76bced4400837e7c7bd033681575d484687bfbbaf1b24a685/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep3&img=https://media.themoviedb.org/t/p/original/9670IbjdSU1ZJL0kjccHIRRwbKX.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s3-ep4", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/gR33y5RTQbuIRXlRYLAUTWta3PK.jpg",
    title: "Watch Mirzapur Season 03 Episode 04",
    video: "series.html?source=https://ai.bigtimedelivery.net/_v13/2a8695286910d04d2d2b7b9923b7e857850161ad06cf33f5a8e4ca758e7b502cf609e7a6a230e6210883ef62341cfc54ae9ae0babf23148c0b2dd724719e3c2c257d3d4e89742adac89c00f88d965e9b948f6f94f2cb9bb93393f5d4eb2bdda58d6053f7bb761b55f38104e4f0bbdbe4ed1d42bd622fe442647ce4cf75092618/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep4&img=https://media.themoviedb.org/t/p/original/5wgBLvyHKEDvuzGNzggoe12xzIU.jpg",
    video2: "series2.html?source=https://ai.bigtimedelivery.net/_v13/2a8695286910d04d2d2b7b9923b7e857850161ad06cf33f5a8e4ca758e7b502cf609e7a6a230e6210883ef62341cfc54ae9ae0babf23148c0b2dd724719e3c2c257d3d4e89742adac89c00f88d965e9b948f6f94f2cb9bb93393f5d4eb2bdda58d6053f7bb761b55f38104e4f0bbdbe4ed1d42bd622fe442647ce4cf75092618/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep4&img=https://media.themoviedb.org/t/p/original/5wgBLvyHKEDvuzGNzggoe12xzIU.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s3-ep5", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/gR33y5RTQbuIRXlRYLAUTWta3PK.jpg",
    title: "Watch Mirzapur Season 03 Episode 05",
    video: "series.html?source=https://ae.bigtimedelivery.net/_v13/af8905c5f476ef6805c63d6d06e2b92f404aab8d113149ff6f787c6bb9482266ac2f64705da2a0b3a4b9e0680c759bd9fb4af8757254a1043367f52fb7c50b9512009aaeb0325ace6c7e335557928f2b51f9877c01e4e7ec41f06b1e0c2c86714e483369a867de871f489ea1b43d5f69f71d9fc0049794c0c989423078dd3a4d/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep5&img=https://media.themoviedb.org/t/p/original/eiMFiJUQTLYWfOZNH6k2Rn7MCs8.jpg",
    video2: "series2.html?source=https://ae.bigtimedelivery.net/_v13/af8905c5f476ef6805c63d6d06e2b92f404aab8d113149ff6f787c6bb9482266ac2f64705da2a0b3a4b9e0680c759bd9fb4af8757254a1043367f52fb7c50b9512009aaeb0325ace6c7e335557928f2b51f9877c01e4e7ec41f06b1e0c2c86714e483369a867de871f489ea1b43d5f69f71d9fc0049794c0c989423078dd3a4d/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep5&img=https://media.themoviedb.org/t/p/original/eiMFiJUQTLYWfOZNH6k2Rn7MCs8.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s3-ep6", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/gR33y5RTQbuIRXlRYLAUTWta3PK.jpg",
    title: "Watch Mirzapur Season 03 Episode 06",
    video: "series.html?source=https://ag.bigtimedelivery.net/_v13/717e09d04fac3732ec836e36d4f98868da27d27db956812aaf5fadcecf4ff60447bb4d26b47028f7c2ed6bcb2c011c546cc5d2c4a85c40c65e72c89a9e74dd0a959d795622b5ae7178e5b67801981b1314c92c1265517f5ec7ffad5708e97726a668b1fbebe08f27c17e6dffe2a02e9c5a5224a20336f97a00a2f72c9cca2e01/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep6&img=https://media.themoviedb.org/t/p/original/27s8VYntlnCw4A40j9O8XW7MftJ.jpg",
    video2: "series2.html?source=https://ag.bigtimedelivery.net/_v13/717e09d04fac3732ec836e36d4f98868da27d27db956812aaf5fadcecf4ff60447bb4d26b47028f7c2ed6bcb2c011c546cc5d2c4a85c40c65e72c89a9e74dd0a959d795622b5ae7178e5b67801981b1314c92c1265517f5ec7ffad5708e97726a668b1fbebe08f27c17e6dffe2a02e9c5a5224a20336f97a00a2f72c9cca2e01/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep6&img=https://media.themoviedb.org/t/p/original/27s8VYntlnCw4A40j9O8XW7MftJ.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s3-ep7", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/gR33y5RTQbuIRXlRYLAUTWta3PK.jpg",
    title: "Watch Mirzapur Season 03 Episode 07",
    video: "series.html?source=https://ag.bigtimedelivery.net/_v13/5cdab1c44e715d1fee3f73896becc573a2b6f08a1478c644c27249d296430363433ca9a9f9fd5b24b4a6c36acc3b9c5f7e290311ec4197b911919856338852c3a932954171e9ce6e6b43be55c9ec89b72a3f452c1587d7c7860aef34a68d54bb85bd36517bae83aecc070b63d82b5948f98f384ca24313df73016bf5b9634604/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep7&img=https://media.themoviedb.org/t/p/original/aDj2WjYA4HlWpY9Te97QiUXcnKk.jpg",
    video2: "series2.html?source=https://ag.bigtimedelivery.net/_v13/5cdab1c44e715d1fee3f73896becc573a2b6f08a1478c644c27249d296430363433ca9a9f9fd5b24b4a6c36acc3b9c5f7e290311ec4197b911919856338852c3a932954171e9ce6e6b43be55c9ec89b72a3f452c1587d7c7860aef34a68d54bb85bd36517bae83aecc070b63d82b5948f98f384ca24313df73016bf5b9634604/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep7&img=https://media.themoviedb.org/t/p/original/aDj2WjYA4HlWpY9Te97QiUXcnKk.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s3-ep8", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/gR33y5RTQbuIRXlRYLAUTWta3PK.jpg",
    title: "Watch Mirzapur Season 03 Episode 08",
    video: "series.html?source=https://aj.bigtimedelivery.net/_v13/400e81eab3829d87e52566a568a31acd08aa382a86569d6ae6dc47bd1856e82d31c74b4e57366647ccbfa6bf239677e795f06b267f6c33e1deaa6083f716834cb348261fbb76f340d3dbc7798fe339c78034fe8b7d8c14ec67c08dc330543f70308eb5f3dbd54176307b924134ad738b17271e555a3c9116414f2773487bc542/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep8&img=https://media.themoviedb.org/t/p/original/jLion9LPUyFDdFccO3wRMqZmjiH.jpg",
    video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/400e81eab3829d87e52566a568a31acd08aa382a86569d6ae6dc47bd1856e82d31c74b4e57366647ccbfa6bf239677e795f06b267f6c33e1deaa6083f716834cb348261fbb76f340d3dbc7798fe339c78034fe8b7d8c14ec67c08dc330543f70308eb5f3dbd54176307b924134ad738b17271e555a3c9116414f2773487bc542/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep8&img=https://media.themoviedb.org/t/p/original/jLion9LPUyFDdFccO3wRMqZmjiH.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s3-ep9", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/gR33y5RTQbuIRXlRYLAUTWta3PK.jpg",
    title: "Watch Mirzapur Season 03 Episode 09",
    video: "series.html?source=https://aa.bigtimedelivery.net/_v13/851b36852dcfefc051b0784ed239e37710438aacde73333a17c43ef6afcb056641eed9b055f6c8147431ce21a3244f491af80ac4500e236b04986f5543768730b110e321aa9c6c28e68eb8a52b1406cf12cfcc53efe86c245a26e8c543daf42563bf4f7d0a92659cf74d4564a2f0320a49acf6099bccf3d7e28495dc1720b03d/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep9&img=https://media.themoviedb.org/t/p/original/91bLYMo6rEAWCTeflnz8Cn6mpMO.jpg",
    video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/851b36852dcfefc051b0784ed239e37710438aacde73333a17c43ef6afcb056641eed9b055f6c8147431ce21a3244f491af80ac4500e236b04986f5543768730b110e321aa9c6c28e68eb8a52b1406cf12cfcc53efe86c245a26e8c543daf42563bf4f7d0a92659cf74d4564a2f0320a49acf6099bccf3d7e28495dc1720b03d/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep9&img=https://media.themoviedb.org/t/p/original/91bLYMo6rEAWCTeflnz8Cn6mpMO.jpg",
    para: "Please be patient while the video loads.",
});
mapRedirect(["mirzapur-s3-ep10", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/gR33y5RTQbuIRXlRYLAUTWta3PK.jpg",
    title: "Watch Mirzapur Season 03 Episode 10",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/0460cbcb05dcfa4f6e336e66385483559db64a708e126703ded2c2a6cdb97561de4fb939bd543be1ff64fd3be0c371ffa7744db76d70b90bc58daeab2e280f915630f56db72ea3934b6dd18f56ee12c3ae775be2357d6823b90459b7007d1af7532135779eaab22fb25c43abaef83ffa648fb7596fd209a0a0ddf78cf4e910d7/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep10&img=https://media.themoviedb.org/t/p/original/5Ah0pv7ERodn0abJ1i5suMFHJYs.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/0460cbcb05dcfa4f6e336e66385483559db64a708e126703ded2c2a6cdb97561de4fb939bd543be1ff64fd3be0c371ffa7744db76d70b90bc58daeab2e280f915630f56db72ea3934b6dd18f56ee12c3ae775be2357d6823b90459b7007d1af7532135779eaab22fb25c43abaef83ffa648fb7596fd209a0a0ddf78cf4e910d7/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Mirzapur%20S03%20Ep10&img=https://media.themoviedb.org/t/p/original/5Ah0pv7ERodn0abJ1i5suMFHJYs.jpg",
    para: "Please be patient while the video loads.",
});

//Heeramandi: The Diamond Bazaar
mapRedirect(["heeramandi-ep1"], {
    splashimgurl: "https://www.primenewsly.com/dhruv/public/uploads/blog/1711635093_30feabab2587c988f9a5.webp",
    title: "Watch Heeramandi: The Diamond Bazaar Season 1 Episode 1",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8y73qc",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8y73qc",
    //video: "series.html?source=https://ad.bigtimedelivery.net/_v13/76beb63ffd5d2b206580416f8f754544d0b37dcc366a6e491eb2d94ce4cce9f4812f4a0d830d7971d9117345f84a50c5f9f651ea27896b79976fedb8b7f86a05da076a9ffe9b354ebd71a83c2434cf201a8365bcee359ede0b5a95dd7c0e3eae822e64c6d4b618844dfa953c92c96b28339ede99cc2077646853dc8b68f36d64/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Heeramandi Ep 1&img=https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABW-6xXB9eQxw08bl4QQVC8v9T7AD-TV_17akeCfYDQKw2bMbJ3ixcGeZWm3I7yU7Vy0vWw6wvsjYBm35DjiNV75jg_IYBrd2Z1q1.jpg",
});
mapRedirect(["heeramandi-ep2"], {
    splashimgurl: "https://www.primenewsly.com/dhruv/public/uploads/blog/1711635093_30feabab2587c988f9a5.webp",
    title: "Watch Heeramandi: The Diamond Bazaar Season 1 Episode 2",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8y73q8",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8y73q8",
    //video: "series.html?source=https://ad.bigtimedelivery.net/_v13/75489b999b1da48ad31362e610f889c3c2d22135195a3ae161b8ae32c89dee3d25b17e0ce06b313389c9711aa2aa6d7dd0e530952c3b723dd3600b63ccc4d07713aa423aff19825f0b6d5d9e79b82c1b73c3f3841a8b967d7d8bd99a7af4a4578a7bb8a8f78e8d6d898132509981743994a707fc936cb0a99942f93eee481214/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Heeramandi Ep 2&img=https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABW-6xXB9eQxw08bl4QQVC8v9T7AD-TV_17akeCfYDQKw2bMbJ3ixcGeZWm3I7yU7Vy0vWw6wvsjYBm35DjiNV75jg_IYBrd2Z1q1.jpg",
});
mapRedirect(["heeramandi-ep3"], {
    splashimgurl: "https://www.primenewsly.com/dhruv/public/uploads/blog/1711635093_30feabab2587c988f9a5.webp",
    title: "Watch Heeramandi: The Diamond Bazaar Season 1 Episode 3",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8y73qa",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8y73qa",
    //video: "series.html?source=https://ad.bigtimedelivery.net/_v13/2873118e05e30c3e3dbd35ae6a84edd08848f63b20d2609659fcac881557916531400cd5544d440ed65a14f8b804f3bd0f637031c4f92328190c5c74c101619ab2b665c2f5df3d62e545fbae38dc35785067eded89d51c25529e7ac6d1b8fa061b9e18ba199845d1b7f7149c19bf35ee0beb885f8f6c08a8cd43ed2773980052/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Heeramandi Ep 3&img=https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABW-6xXB9eQxw08bl4QQVC8v9T7AD-TV_17akeCfYDQKw2bMbJ3ixcGeZWm3I7yU7Vy0vWw6wvsjYBm35DjiNV75jg_IYBrd2Z1q1.jpg",
});
mapRedirect(["heeramandi-ep4"], {
    splashimgurl: "https://www.primenewsly.com/dhruv/public/uploads/blog/1711635093_30feabab2587c988f9a5.webp",
    title: "Watch Heeramandi: The Diamond Bazaar Season 1 Episode 4",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8y73q6",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8y73q6",
    // video: "series.html?source=https://ad.bigtimedelivery.net/_v13/27e3b28dd259702cabf9c22f00d8497cd376f67850594b37d46e61e6823bfb085a1fd2d16b40c6fefd77a082c72228bf37cbcb663d67bbe76e3ae5711933b33e9f4f1dc0dc21ceef4a4a32203461822787c16b9df942d47498c0e450cc53ad39983c0eb5a5a0cbb3960401e2609260609e749803a1b54482177de3de93c52ac7/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Heeramandi Ep 4&img=https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABW-6xXB9eQxw08bl4QQVC8v9T7AD-TV_17akeCfYDQKw2bMbJ3ixcGeZWm3I7yU7Vy0vWw6wvsjYBm35DjiNV75jg_IYBrd2Z1q1.jpg",
});
mapRedirect(["heeramandi-ep5"], {
    splashimgurl: "https://www.primenewsly.com/dhruv/public/uploads/blog/1711635093_30feabab2587c988f9a5.webp",
    title: "Watch Heeramandi: The Diamond Bazaar Season 1 Episode 5",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8y73u8",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8y73u8",
    //video: "series.html?source=https://ad.bigtimedelivery.net/_v13/18bada88f2b3fcd31b88e170eae33c39c4bbea16f6fff583afe13e4da39b14c738055df555dbed5e8dfb5c8d3b866fc71bd4f97f61a85c22854f48757e35a940a232d1dba58a86b9c8600f60b4595b28ff9ad7c61986c57a78299e652e9472790ca78924522e4f6716a80f19c28e589d2ed23a12fd02e30d085948ab8a5b5dd9/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Heeramandi Ep 5&img=https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABW-6xXB9eQxw08bl4QQVC8v9T7AD-TV_17akeCfYDQKw2bMbJ3ixcGeZWm3I7yU7Vy0vWw6wvsjYBm35DjiNV75jg_IYBrd2Z1q1.jpg",
});
mapRedirect(["heeramandi-ep6"], {
    splashimgurl: "https://www.primenewsly.com/dhruv/public/uploads/blog/1711635093_30feabab2587c988f9a5.webp",
    title: "Watch Heeramandi: The Diamond Bazaar Season 1 Episode 6",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8y73vu",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8y73vu",
    // video: "series.html?source=https://ad.bigtimedelivery.net/_v13/3d405b1f2223d9a4cbe2af2eab54853c56ab006a17f0ea84459ca92cfa0ca15afe708ba31156b5273cb7484ee5f240d4aa2c7ab614dcc22e45bb64c04c0555ee443823b8147422df9c13094b9216286d3d383555ec7f8569f49cfffcb09afa27b4366cbcdf8efea2ecd4852ec7a3df80faccf3fbffa8e61e74d43a0af0269c33/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Heeramandi Ep 6&img=https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABW-6xXB9eQxw08bl4QQVC8v9T7AD-TV_17akeCfYDQKw2bMbJ3ixcGeZWm3I7yU7Vy0vWw6wvsjYBm35DjiNV75jg_IYBrd2Z1q1.jpg",
});
mapRedirect(["heeramandi-ep7"], {
    splashimgurl: "https://www.primenewsly.com/dhruv/public/uploads/blog/1711635093_30feabab2587c988f9a5.webp",
    title: "Watch Heeramandi: The Diamond Bazaar Season 1 Episode 7",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8y7400",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8y7400",
    //  video: "series.html?source=https://ad.bigtimedelivery.net/_v13/3b60c418cbca7cf580f382a474eb81c48d722fc805ee7f06e45910426504153ea1b15466c2df842b6936ce3a5ecd83883c474fb32c2ab7a077f2bfaa354515fcbc87cf35dfeb014aa76970a041e89e531f51d7fa8b9a74e06460c32a07137c5c610a5be5af4e9fb3c8319ace6afe2cb0ed07cab07f6ee7ca69f576ef18fbc6f5/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Heeramandi Ep 7&img=https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABW-6xXB9eQxw08bl4QQVC8v9T7AD-TV_17akeCfYDQKw2bMbJ3ixcGeZWm3I7yU7Vy0vWw6wvsjYBm35DjiNV75jg_IYBrd2Z1q1.jpg",
});
mapRedirect(["heeramandi-ep8"], {
    splashimgurl: "https://www.primenewsly.com/dhruv/public/uploads/blog/1711635093_30feabab2587c988f9a5.webp",
    title: "Watch Heeramandi: The Diamond Bazaar Season 1 Episode 8",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8y7410",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8y7410",
    //  video: "series.html?source=https://ad.bigtimedelivery.net/_v13/a1ed4afd25fc9a94767ccfa6595f53d4321f6779f9251efba7c6162535cd431686a9a62d5cd5401f07fd25222928421b82819e5b0968d53dbb3d57abcf988e00a24aa40e3f1f8ac79c28c97dbb82a7c7c0351033ef91025eec6def2c084a23ccc46b7c17ed85f9117ea259a35becf548df0a6831b9dd42bb5a38d8ceb3cc2a4c/playlist.m3u8&subcode=en&substitleurl=substitles/series-sub.srt&title-1=Heeramandi Ep 8&img=https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABW-6xXB9eQxw08bl4QQVC8v9T7AD-TV_17akeCfYDQKw2bMbJ3ixcGeZWm3I7yU7Vy0vWw6wvsjYBm35DjiNV75jg_IYBrd2Z1q1.jpg",
});

//The Regime
mapRedirect(["the-regime-s1-ep1"], {
    splashimgurl: "https://filmtopp.b-cdn.net/media/2024/03/The_Regime102.jpg?w=900&h=700&crop=top&auto=format",
    title: "Watch The Regime Season 01 Episode 01 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/085388d2c2880f65e37a33462b74796b8b23365a3a7ee5b1f03135a95128167d82a037d36724ed5cc91adb4a710340235ad015db3dbaccec7702fa849d7527bab1be77e11b3b0784ec73b16a787702f3159af4df1fbbdb73b20d5d2d228c10ba88c9dd9f3313c89374c3cfbfa3bbbf2c1925c7f2cf7efa95117aa88456fe606c71152b3deccea3bd11f960866a6053be/playlist.m3u8&title-1=The Regime Ep01&img=https://m.media-amazon.com/images/M/MV5BMDhkY2Y3MGMtNGRhMy00NjUyLWI5MjYtZWM5ODU2OGRhMTM4XkEyXkFqcGdeQXVyMTE0MzQwMjgz._V1.jpg&subcode=en&substitleurl=substitles/Series/The.Regime.S01/The.Regime.S01.E01.En.srt",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/085388d2c2880f65e37a33462b74796b8b23365a3a7ee5b1f03135a95128167d82a037d36724ed5cc91adb4a710340235ad015db3dbaccec7702fa849d7527bab1be77e11b3b0784ec73b16a787702f3159af4df1fbbdb73b20d5d2d228c10ba88c9dd9f3313c89374c3cfbfa3bbbf2c1925c7f2cf7efa95117aa88456fe606c71152b3deccea3bd11f960866a6053be/playlist.m3u8&title-1=The Regime Ep01&img=https://m.media-amazon.com/images/M/MV5BMDhkY2Y3MGMtNGRhMy00NjUyLWI5MjYtZWM5ODU2OGRhMTM4XkEyXkFqcGdeQXVyMTE0MzQwMjgz._V1.jpg&subcode=en&substitleurl=substitles/Series/The.Regime.S01/The.Regime.S01.E01.En.srt",
});
mapRedirect(["the-regime-s1-ep2"], {
    splashimgurl: "https://filmtopp.b-cdn.net/media/2024/03/The_Regime102.jpg?w=900&h=700&crop=top&auto=format",
    title: "Watch The Regime Season 01 Episode 02 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/e11027009c3ad6d50325b7f8c26cd5072a88537b441f473564d0643e37e3827e4844b923796d47ab97a9c5d75c8f55d2ca54a7edaf23bdc5fcd7d6277671125679ab977c6921e93c14f882a7c890bfe111f5cba6a633f350e378c602641da211f8aee57978c49bcfd3f1062d487db455fe571f3e0b6053fbfc4a1ed1798e1cafa1c8b10bda397b99955128e3084f2cde/playlist.m3u8&title-1=The Regime Ep02&img=https://m.media-amazon.com/images/M/MV5BNTQzNGYwMTYtMTBhNi00ZjkwLTk0OTgtOTBmZmZkNDk0ZGI2XkEyXkFqcGdeQXVyMTE0MzQwMjgz._V1.jpg&subcode=en&substitleurl=substitles/Series/The.Regime.S01/The.Regime.S01.E02.En.srt",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/e11027009c3ad6d50325b7f8c26cd5072a88537b441f473564d0643e37e3827e4844b923796d47ab97a9c5d75c8f55d2ca54a7edaf23bdc5fcd7d6277671125679ab977c6921e93c14f882a7c890bfe111f5cba6a633f350e378c602641da211f8aee57978c49bcfd3f1062d487db455fe571f3e0b6053fbfc4a1ed1798e1cafa1c8b10bda397b99955128e3084f2cde/playlist.m3u8&title-1=The Regime Ep02&img=https://m.media-amazon.com/images/M/MV5BNTQzNGYwMTYtMTBhNi00ZjkwLTk0OTgtOTBmZmZkNDk0ZGI2XkEyXkFqcGdeQXVyMTE0MzQwMjgz._V1.jpg&subcode=en&substitleurl=substitles/Series/The.Regime.S01/The.Regime.S01.E02.En.srt",
});
mapRedirect(["the-regime-s1-ep3"], {
    splashimgurl: "https://filmtopp.b-cdn.net/media/2024/03/The_Regime102.jpg?w=900&h=700&crop=top&auto=format",
    title: "Watch The Regime Season 01 Episode 03 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/21a16e2f07c484cae266b01033739eb6080f4fd56c05f864991770520317f109882fee76065b472be7cef9572e28966ae6375709b0409aa0b238ea039e34b40625d1fe2ede635593e1e792edfd7bf15ab1f8d043a4bf47a621cb8ab66f0c3d24550881b975f5d27e560f123bb02322b0391db65ee0dd42ec9e10b909872b55b3/playlist.m3u8&title-1=The Regime Ep03&img=https://m.media-amazon.com/images/M/MV5BOThhMDZkZDEtMGRlNS00YjdmLTkwYTQtZDljMDJmNGJkZjAzXkEyXkFqcGdeQXVyMTE0MzQwMjgz._V1.jpg&subcode=en&substitleurl=substitles/Series/The.Regime.S01/The.Regime.S01.E03.En.srt",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/21a16e2f07c484cae266b01033739eb6080f4fd56c05f864991770520317f109882fee76065b472be7cef9572e28966ae6375709b0409aa0b238ea039e34b40625d1fe2ede635593e1e792edfd7bf15ab1f8d043a4bf47a621cb8ab66f0c3d24550881b975f5d27e560f123bb02322b0391db65ee0dd42ec9e10b909872b55b3/playlist.m3u8&title-1=The Regime Ep03&img=https://m.media-amazon.com/images/M/MV5BOThhMDZkZDEtMGRlNS00YjdmLTkwYTQtZDljMDJmNGJkZjAzXkEyXkFqcGdeQXVyMTE0MzQwMjgz._V1.jpg&subcode=en&substitleurl=substitles/Series/The.Regime.S01/The.Regime.S01.E03.En.srt",
});
mapRedirect(["the-regime-s1-ep4"], {
    splashimgurl: "https://filmtopp.b-cdn.net/media/2024/03/The_Regime102.jpg?w=900&h=700&crop=top&auto=format",
    title: "Watch The Regime Season 01 Episode 04 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/688f482a7090456d0e9ff18ea95b663f3d93bce980d5483fae471ace3820ecb1379bb36bc493cc6367de7030297920f90c0ef4fcf057e722cbe7eda0466b7c93037e12d91a6672184c0b4defdc50cd0e1d1737db68fbb720e7a2f73d12286e1ef7cccd1a34706fb7935bb4c98bec3a3063a6fbbf2d81a5a8e7630ce57a6ebd31/playlist.m3u8&title-1=The Regime Ep04&img=https://m.media-amazon.com/images/M/MV5BYzc3Y2IyMDAtMzVmNi00NDAwLWFkNzMtYzk1ZjI5MjgxNGU4XkEyXkFqcGdeQXVyMTA4MjY1NjMz._V1.jpg&subcode=en&substitleurl=substitles/Series/The.Regime.S01/The.Regime.S01.E04.En.srt",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/688f482a7090456d0e9ff18ea95b663f3d93bce980d5483fae471ace3820ecb1379bb36bc493cc6367de7030297920f90c0ef4fcf057e722cbe7eda0466b7c93037e12d91a6672184c0b4defdc50cd0e1d1737db68fbb720e7a2f73d12286e1ef7cccd1a34706fb7935bb4c98bec3a3063a6fbbf2d81a5a8e7630ce57a6ebd31/playlist.m3u8&title-1=The Regime Ep04&img=https://m.media-amazon.com/images/M/MV5BYzc3Y2IyMDAtMzVmNi00NDAwLWFkNzMtYzk1ZjI5MjgxNGU4XkEyXkFqcGdeQXVyMTA4MjY1NjMz._V1.jpg&subcode=en&substitleurl=substitles/Series/The.Regime.S01/The.Regime.S01.E04.En.srt",
});
mapRedirect(["the-regime-s1-ep5"], {
    splashimgurl: "https://filmtopp.b-cdn.net/media/2024/03/The_Regime102.jpg?w=900&h=700&crop=top&auto=format",
    title: "Watch The Regime Season 01 Episode 05 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/00c13198cda036189501cfe876fa975e7e2c4ab8e693e52d8ac3a0e32efc291589afabd87bce2c5c1dce3c0b7654d6706069ba8daf68f09ea410e1e3b4dde21ed9ef42e13377422b25c81f89063035e84ccda3999cd38ba4ec84f7e0673e58737d5f6ccdf2369ca057dfd86fc8816c691e548b6c9723ae70b322b31f85becc64/playlist.m3u8&title-1=The Regime Ep05&img=https://m.media-amazon.com/images/M/MV5BNmZiNGRlNDktZDhlYy00ODNjLWI5NjktNjA1NGZiMTE4NmRkXkEyXkFqcGdeQXVyMTAyMjQ3NzQ1._V1.jpg&subcode=en&substitleurl=substitles/Series/The.Regime.S01/The.Regime.S01.E05.En.srt",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/00c13198cda036189501cfe876fa975e7e2c4ab8e693e52d8ac3a0e32efc291589afabd87bce2c5c1dce3c0b7654d6706069ba8daf68f09ea410e1e3b4dde21ed9ef42e13377422b25c81f89063035e84ccda3999cd38ba4ec84f7e0673e58737d5f6ccdf2369ca057dfd86fc8816c691e548b6c9723ae70b322b31f85becc64/playlist.m3u8&title-1=The Regime Ep05&img=https://m.media-amazon.com/images/M/MV5BNmZiNGRlNDktZDhlYy00ODNjLWI5NjktNjA1NGZiMTE4NmRkXkEyXkFqcGdeQXVyMTAyMjQ3NzQ1._V1.jpg&subcode=en&substitleurl=substitles/Series/The.Regime.S01/The.Regime.S01.E05.En.srt",
});
mapRedirect(["the-regime-s1-ep6"], {
    splashimgurl: "https://filmtopp.b-cdn.net/media/2024/03/The_Regime102.jpg?w=900&h=700&crop=top&auto=format",
    title: "Watch The Regime Season 01 Episode 06 English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/23aab9bcd196d57257dfa31e86e07124d0ca2415fcf8b9ed718a558351f407f1809f8177bcd532ae4718adeeb78a316246c74f4fee913351159e4f5e34ae29553c21d321f35a154733c8990cd06add8bc30f90f0067bf1a4ad5781e68e75bcc1dd11f7fc8a34159989b3dad7bc6efecff0629fc2929a50bcb6b45481711cb8aa/playlist.m3u8&title-1=The Regime Ep06&img=https://m.media-amazon.com/images/M/MV5BZThhNGQyMTctYWI2NS00MzMyLWE3NmYtYjUxNjU3Y2VkZGZmXkEyXkFqcGdeQXVyNTA2NDY2MzA@._V1.jpg&subcode=en&substitleurl=substitles/Series/The.Regime.S01/The.Regime.S01.E06.En.srt",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/23aab9bcd196d57257dfa31e86e07124d0ca2415fcf8b9ed718a558351f407f1809f8177bcd532ae4718adeeb78a316246c74f4fee913351159e4f5e34ae29553c21d321f35a154733c8990cd06add8bc30f90f0067bf1a4ad5781e68e75bcc1dd11f7fc8a34159989b3dad7bc6efecff0629fc2929a50bcb6b45481711cb8aa/playlist.m3u8&title-1=The Regime Ep06&img=https://m.media-amazon.com/images/M/MV5BZThhNGQyMTctYWI2NS00MzMyLWE3NmYtYjUxNjU3Y2VkZGZmXkEyXkFqcGdeQXVyNTA2NDY2MzA@._V1.jpg&subcode=en&substitleurl=substitles/Series/The.Regime.S01/The.Regime.S01.E06.En.srt",
});

//You Season 01
mapRedirect(["you-s1-ep1"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 1 Episode 1 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/eaa25a9f00dcc15ca04d762e38ec2beb7cf5fcab2450ce72fb2c45c6ad7bb547e74d533946713560daf6eb22bbd4930e0142d175130e183c7974500752a58c1b65ffdd66f8226781bbf9f69b8cb9c79716066b64362a98d857033640485a4f077d975eeba741d28f67ed38e043218da43f314c64846e0b90e08551fa37d2accf/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep1-eng.srt&title-1=You%20S1%20Ep%201&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/eaa25a9f00dcc15ca04d762e38ec2beb7cf5fcab2450ce72fb2c45c6ad7bb547e74d533946713560daf6eb22bbd4930e0142d175130e183c7974500752a58c1b65ffdd66f8226781bbf9f69b8cb9c79716066b64362a98d857033640485a4f077d975eeba741d28f67ed38e043218da43f314c64846e0b90e08551fa37d2accf/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep1-eng.srt&title-1=You%20S1%20Ep%201&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
});
mapRedirect(["you-s1-ep2"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 1 Episode 2 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/48d880fc773af46c4255200b052c7692f7a1d5e2d22e772c17f496591e25f780cf7aeff61557f9a3df647c45a852f0ca55bd2a83ef45259a275e1384f94b08a8f70899e1a20969bf088150ec5e4af5a2fd44ff5b84fdfd8e0b8c45140ff215823bd70666d3e331540582a12221b5b6940fc2931c4060984babd4d7cea648912b/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep2-eng.srt&title-1=You%20S1%20Ep%202&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/48d880fc773af46c4255200b052c7692f7a1d5e2d22e772c17f496591e25f780cf7aeff61557f9a3df647c45a852f0ca55bd2a83ef45259a275e1384f94b08a8f70899e1a20969bf088150ec5e4af5a2fd44ff5b84fdfd8e0b8c45140ff215823bd70666d3e331540582a12221b5b6940fc2931c4060984babd4d7cea648912b/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep2-eng.srt&title-1=You%20S1%20Ep%202&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
});
mapRedirect(["you-s1-ep3"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 1 Episode 3 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/36439f5da79af54077896293243c7f2dc93b08fe51e655e34e8d1a85e5c88007e05d5056a9cc1651da359bf173413e579fb6380588e0281c06feb25b8f8d8e33d529622063206f7d6163419997226347208459000b240351ec605cd106150ab3fe2c5a5c2d250c5ff87667fca90512d5731ebede16b608ad36f4da7577357af1/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep3-eng.srt&title-1=You%20S1%20Ep%203&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/36439f5da79af54077896293243c7f2dc93b08fe51e655e34e8d1a85e5c88007e05d5056a9cc1651da359bf173413e579fb6380588e0281c06feb25b8f8d8e33d529622063206f7d6163419997226347208459000b240351ec605cd106150ab3fe2c5a5c2d250c5ff87667fca90512d5731ebede16b608ad36f4da7577357af1/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep3-eng.srt&title-1=You%20S1%20Ep%203&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
});
mapRedirect(["you-s1-ep4"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 1 Episode 4 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/c12225ec00c2d9ea365877f10d7b6d597d95008feb54c13b3ae14f8f9573eefcb95b1c53537ad365a640927429bafe2a9ec86c9ca1e0427940f029eaa37dcb39d4eb8d611a7feb84faadd7434d4bcfb7b8c7415492d9997e9dacab148210678eec8861f2331c97599448bc855e8f254b953804753ba851d05ffc34ddda9574bd/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep4-eng.srt&title-1=You%20S1%20Ep%204&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/c12225ec00c2d9ea365877f10d7b6d597d95008feb54c13b3ae14f8f9573eefcb95b1c53537ad365a640927429bafe2a9ec86c9ca1e0427940f029eaa37dcb39d4eb8d611a7feb84faadd7434d4bcfb7b8c7415492d9997e9dacab148210678eec8861f2331c97599448bc855e8f254b953804753ba851d05ffc34ddda9574bd/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep4-eng.srt&title-1=You%20S1%20Ep%204&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
});
mapRedirect(["you-s1-ep5"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 1 Episode 5 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/48b9b692e2ac341d73c0b2f6dc09473d329d12a947925e06661b93250866f2a817dba7270a83ec74f77fe0eea3e01ccf1ab2e11c92bf45989f194e66abd309defb9ee305399f724df05d13550112754dd4392fc3f4f6e699dd7586220a61a400a2280133ee2c34eb63aa484a3547fc622d111848b4b57fcde94abb0a2dd1da12/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep5-eng.srt&title-1=You%20S1%20Ep%205&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/48b9b692e2ac341d73c0b2f6dc09473d329d12a947925e06661b93250866f2a817dba7270a83ec74f77fe0eea3e01ccf1ab2e11c92bf45989f194e66abd309defb9ee305399f724df05d13550112754dd4392fc3f4f6e699dd7586220a61a400a2280133ee2c34eb63aa484a3547fc622d111848b4b57fcde94abb0a2dd1da12/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep5-eng.srt&title-1=You%20S1%20Ep%205&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
});
mapRedirect(["you-s1-ep6"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 1 Episode 6 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/02c9f2bcff8acfe8644f6bb052f66313bab2e6de2bb0006eb0fa3c44d034979735121b3047718411c994a6c4831bec196ff5148d1a7af9b5ee1e64f09260fb55bd737a208869e10694df4582ddf1b22994da505dc7d11b3fba7d1ec684e26b134088bbb86a93ab7356f1897cfe0f7b42329ff24ceac3e1a3dacd7a20717cdfd0/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep6-eng.srt&title-1=You%20S1%20Ep%206&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/02c9f2bcff8acfe8644f6bb052f66313bab2e6de2bb0006eb0fa3c44d034979735121b3047718411c994a6c4831bec196ff5148d1a7af9b5ee1e64f09260fb55bd737a208869e10694df4582ddf1b22994da505dc7d11b3fba7d1ec684e26b134088bbb86a93ab7356f1897cfe0f7b42329ff24ceac3e1a3dacd7a20717cdfd0/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep6-eng.srt&title-1=You%20S1%20Ep%206&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
});
mapRedirect(["you-s1-ep7"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 1 Episode 7 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/2c2dcb9281ca35cd5ad20189bcc0c23862b3650c9458342b0ab02b0d263e4784df41eca5c212a076ac7174637974275cfdb983db9686655156145324acb77a0c4ef59b68c8eee4893b30d990c674a5cee60c49b3baf86564e9fdde110f17ce3c8ae5220e73a1e36a085589a3b110e82e3b338ee67452b7ab4c9695e49a256f8f/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep7-eng.srt&title-1=You%20S1%20Ep%207&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/2c2dcb9281ca35cd5ad20189bcc0c23862b3650c9458342b0ab02b0d263e4784df41eca5c212a076ac7174637974275cfdb983db9686655156145324acb77a0c4ef59b68c8eee4893b30d990c674a5cee60c49b3baf86564e9fdde110f17ce3c8ae5220e73a1e36a085589a3b110e82e3b338ee67452b7ab4c9695e49a256f8f/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep7-eng.srt&title-1=You%20S1%20Ep%207&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
});
mapRedirect(["you-s1-ep8"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 1 Episode 8 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/9f56cc08f4119e292deb7891c9e9f3831ead1e69af6a093646d8df0da768d6ea7f0da80906a61f50e7d81d0ec0912632f7d8556954ec3e90b6fec452bc735dfd96a734319a18c6e2c8604f2511b60e517561b15b8d845fa5233597dca8c524c9e49af15e41fcfc3ca147e945553960d60fd91850cb0e77a41efe4c18bed9f1cf/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep8-eng.srt&title-1=You%20S1%20Ep%208&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/9f56cc08f4119e292deb7891c9e9f3831ead1e69af6a093646d8df0da768d6ea7f0da80906a61f50e7d81d0ec0912632f7d8556954ec3e90b6fec452bc735dfd96a734319a18c6e2c8604f2511b60e517561b15b8d845fa5233597dca8c524c9e49af15e41fcfc3ca147e945553960d60fd91850cb0e77a41efe4c18bed9f1cf/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep8-eng.srt&title-1=You%20S1%20Ep%208&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
});
mapRedirect(["you-s1-ep9"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 1 Episode 9 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/43adea6477573134a41696bf5474be2a3c6f84ba3f8f56f3715a730f730f55c9dfdc3d1e905c4f85dbdd159d41369950e30fdc829935ca69941cc361a80b7a22fe7b5e0ed8e93a17da48d818afb809761d3833a4a7e2a256cbdc5bfbc0b417023d9bf590230f0da621a3739a8bb7790779cbb9a0ea1644a4dec3f2010b822c99/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep9-eng.srt&title-1=You%20S1%20Ep%209&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/43adea6477573134a41696bf5474be2a3c6f84ba3f8f56f3715a730f730f55c9dfdc3d1e905c4f85dbdd159d41369950e30fdc829935ca69941cc361a80b7a22fe7b5e0ed8e93a17da48d818afb809761d3833a4a7e2a256cbdc5bfbc0b417023d9bf590230f0da621a3739a8bb7790779cbb9a0ea1644a4dec3f2010b822c99/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep9-eng.srt&title-1=You%20S1%20Ep%209&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
});
mapRedirect(["you-s1-ep10"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 1 Episode 10 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/eba254f6175c0ef06d2fc3b8b70fcd6cfad4fe8171fa65336c3ef72a08d594b8938ea4847402d861060340e787ee72eccf4fb8d51497fb65e5148e856dedc1a5d642582b87af9a1dfb119f2ce3b994ddd8e2dd7c61775d188feba4225706b5f5643899a225870431fa399e5def0af57d129c22edbe5df40dacaf51b8bf85e745/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep10-eng.srt&title-1=You%20S1%20Ep%2010&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/eba254f6175c0ef06d2fc3b8b70fcd6cfad4fe8171fa65336c3ef72a08d594b8938ea4847402d861060340e787ee72eccf4fb8d51497fb65e5148e856dedc1a5d642582b87af9a1dfb119f2ce3b994ddd8e2dd7c61775d188feba4225706b5f5643899a225870431fa399e5def0af57d129c22edbe5df40dacaf51b8bf85e745/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s1-ep10-eng.srt&title-1=You%20S1%20Ep%2010&img=https://media.themoviedb.org/t/p/original/e92qfYRVYUL602ztyEoujUtXlS1.jpg",
});

// You Season 02
mapRedirect(["you-s2-ep1"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 2 Episode 1 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/9ff0b549807919aed63c03f4b47649973301fd69166da65025c76970178c6633098a5cec929342c1f669635f2d3d7592297ae3edc2486c8e8f3415440c2e56efae8f2f23a04130cdade2dba34f818c63032cff388b42475904eba7417dfa9bd7dbe6446d744e0c3a902c6502993c49ac7cbdf94cfc47eb46de07c80e5c3ffaf4075d8185db64c5e65f36f9ce89128754/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep1-eng.srt&title-1=You%20S2%20Ep%201&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/9ff0b549807919aed63c03f4b47649973301fd69166da65025c76970178c6633098a5cec929342c1f669635f2d3d7592297ae3edc2486c8e8f3415440c2e56efae8f2f23a04130cdade2dba34f818c63032cff388b42475904eba7417dfa9bd7dbe6446d744e0c3a902c6502993c49ac7cbdf94cfc47eb46de07c80e5c3ffaf4075d8185db64c5e65f36f9ce89128754/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep1-eng.srt&title-1=You%20S2%20Ep%201&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
});
mapRedirect(["you-s2-ep2"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 2 Episode 2 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/badb34da719b7739be72639eac5af8bcdf070cbc9d1214042769670a3d99a732a6614f52f11b71be2c08ed2beb6c287b9560821922b3041f5d0335d5eaf807448c223ea7824e8997f1bfc37f9c005cbd764d06a27e7e226936020f48e9da93eb0c212e8c31e0572221cca87bba4fa95b807c335efaf689111421e2d7bf374fe51894c904e046e8d1adbfb3c16f394bd9/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep2-eng.srt&title-1=You%20S2%20Ep%202&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/badb34da719b7739be72639eac5af8bcdf070cbc9d1214042769670a3d99a732a6614f52f11b71be2c08ed2beb6c287b9560821922b3041f5d0335d5eaf807448c223ea7824e8997f1bfc37f9c005cbd764d06a27e7e226936020f48e9da93eb0c212e8c31e0572221cca87bba4fa95b807c335efaf689111421e2d7bf374fe51894c904e046e8d1adbfb3c16f394bd9/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep2-eng.srt&title-1=You%20S2%20Ep%202&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
});
mapRedirect(["you-s2-ep3"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 2 Episode 3 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/9cff899ad5f7142e90dc2b174c3cb3807efd0de3dc6b0c99538bc33b3cedf5f8acac4aa4f86e24c5ce3ce5a44328cf67a434a2ecf5a7cf2ed6c841e2160cc0c033931565c03758eb112d4c8826d5f8ef408dc919a091d9d50f3aafebb36ee4ad201fbce17c40137020a29e750537b7becd9c8c205d628bfc1e8582d990e09005da66400526ebc0e2bf3e5d6ae3c2eec8/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep3-eng.srt&title-1=You%20S2%20Ep%203&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/9cff899ad5f7142e90dc2b174c3cb3807efd0de3dc6b0c99538bc33b3cedf5f8acac4aa4f86e24c5ce3ce5a44328cf67a434a2ecf5a7cf2ed6c841e2160cc0c033931565c03758eb112d4c8826d5f8ef408dc919a091d9d50f3aafebb36ee4ad201fbce17c40137020a29e750537b7becd9c8c205d628bfc1e8582d990e09005da66400526ebc0e2bf3e5d6ae3c2eec8/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep3-eng.srt&title-1=You%20S2%20Ep%203&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
});
mapRedirect(["you-s2-ep4"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 2 Episode 4 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/cc2ec48c234a559b745f9374919e2175bf43c683a02a04d5e2445492def6a85bad15ba95cbcddce24dc773e5896f14a5cc82232d4e590d4d84af792793154aee0391798602accd78087d1cd0eecfec95985a06d86e42d921de03658bceb14e4774a9fd64e42f1a5d552c5f7e04229b0d531f5cc7be4e62cc418edff106b6df057c2395a3105e16fa0595a1adb9b49f9a/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep4-eng.srt&title-1=You%20S2%20Ep%204&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/cc2ec48c234a559b745f9374919e2175bf43c683a02a04d5e2445492def6a85bad15ba95cbcddce24dc773e5896f14a5cc82232d4e590d4d84af792793154aee0391798602accd78087d1cd0eecfec95985a06d86e42d921de03658bceb14e4774a9fd64e42f1a5d552c5f7e04229b0d531f5cc7be4e62cc418edff106b6df057c2395a3105e16fa0595a1adb9b49f9a/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep4-eng.srt&title-1=You%20S2%20Ep%204&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
});
mapRedirect(["you-s2-ep5"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 2 Episode 5 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/1f52b43ae7108b6b85f10ce75ea367ddf0229d3fda445859e897ccb589d6feb8916d1c3a2b75d4b2b3067ca6f266ca2f77955820ddf86ea5d4848416bc0f6f39d94424be82931f1c0455add954b2a4bf4c1a196e5bfba6a187ab5f296beac0a10a8c1e077821311ef864e8431ab435018042b329dc0887c0ca3981dd0437e89724de1bd487531421833f1bc7f20d92d5/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep5-eng.srt&title-1=You%20S2%20Ep%205&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/1f52b43ae7108b6b85f10ce75ea367ddf0229d3fda445859e897ccb589d6feb8916d1c3a2b75d4b2b3067ca6f266ca2f77955820ddf86ea5d4848416bc0f6f39d94424be82931f1c0455add954b2a4bf4c1a196e5bfba6a187ab5f296beac0a10a8c1e077821311ef864e8431ab435018042b329dc0887c0ca3981dd0437e89724de1bd487531421833f1bc7f20d92d5/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep5-eng.srt&title-1=You%20S2%20Ep%205&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
});
mapRedirect(["you-s2-ep6"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 2 Episode 6 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/2662869f64662870d80b45a1bd2174d447f2f8ce0aaf6b951212a0a583ad9887c92f104c8a8d1d027da71d6c99733bda45062c415e0eb83f6d6104a123933a85d19a5ab77a095e2af5f746c47ae899759d50dbf73fb692cbe9fd37773df6486d1826e0293504243429d0e6e207b36794a1d899a14d432994336f73bae0decdfbc7d734920840b7274b1a2531095388a1/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep6-eng.srt&title-1=You%20S2%20Ep%206&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/2662869f64662870d80b45a1bd2174d447f2f8ce0aaf6b951212a0a583ad9887c92f104c8a8d1d027da71d6c99733bda45062c415e0eb83f6d6104a123933a85d19a5ab77a095e2af5f746c47ae899759d50dbf73fb692cbe9fd37773df6486d1826e0293504243429d0e6e207b36794a1d899a14d432994336f73bae0decdfbc7d734920840b7274b1a2531095388a1/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep6-eng.srt&title-1=You%20S2%20Ep%206&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
});
mapRedirect(["you-s2-ep7"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 2 Episode 7 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/cbfe672c0e69f6e570110e9ce9152451d4a9dff1eb9c80f215038c35acd0e31288e57d1187d8e00f17fe2f2820e23477525648ced3e85ee3fc598b3878b001110c91df8edf3878f3c337c9ea461ef51331e0a64f632b094a44d2f3e7c6159d674b7c4f53071172a76588d3037c57e9ba57c1848bdaf6017f8dc34d0269374afd845f515eb072741f70b8146d34484282/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep7-eng.srt&title-1=You%20S2%20Ep%207&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/cbfe672c0e69f6e570110e9ce9152451d4a9dff1eb9c80f215038c35acd0e31288e57d1187d8e00f17fe2f2820e23477525648ced3e85ee3fc598b3878b001110c91df8edf3878f3c337c9ea461ef51331e0a64f632b094a44d2f3e7c6159d674b7c4f53071172a76588d3037c57e9ba57c1848bdaf6017f8dc34d0269374afd845f515eb072741f70b8146d34484282/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep7-eng.srt&title-1=You%20S2%20Ep%207&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
});
mapRedirect(["you-s2-ep8"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 2 Episode 8 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/92831b5f7634ee72049867d2cad5f3a3cba62dadd98f37b405ccd4507dbc43a6527610db1bcc9569001302acbad8cbd7e0ed64a58f8edf03418edb774d8e1027df28d3cd544068bd0d1df77af5296e76229f1232fc5e55a8da30cd129e721ab3b381da4a9ab50cc01dc12c45fbddc408bfb8fde02c98ab120e78f106409b712bed05909ecc63bc98eb4bdfe3364cf2d0/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep8-eng.srt&title-1=You%20S2%20Ep%208&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/92831b5f7634ee72049867d2cad5f3a3cba62dadd98f37b405ccd4507dbc43a6527610db1bcc9569001302acbad8cbd7e0ed64a58f8edf03418edb774d8e1027df28d3cd544068bd0d1df77af5296e76229f1232fc5e55a8da30cd129e721ab3b381da4a9ab50cc01dc12c45fbddc408bfb8fde02c98ab120e78f106409b712bed05909ecc63bc98eb4bdfe3364cf2d0/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep8-eng.srt&title-1=You%20S2%20Ep%208&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
});
mapRedirect(["you-s2-ep9"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 2 Episode 9 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/c4a1f47837a5350aa4d36c386f5f68c7efd7f50e2a19097d73e82e83c8394b675ba0a22bdd2ca41a25c109269249c65102a2e8f027d0d360edd9c3f6bb4d97f9c3ead0af4baaba167650f6610af596bba2b77a7510c1908218d8dc70e7ce8a7512637dedded487ef921f06c32c7e156be60d8c6911bfa917407c0d095eabd3f4cb711af56d9f58805bb1e76ae6cb9075/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep9-eng.srt&title-1=You%20S2%20Ep%209&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/c4a1f47837a5350aa4d36c386f5f68c7efd7f50e2a19097d73e82e83c8394b675ba0a22bdd2ca41a25c109269249c65102a2e8f027d0d360edd9c3f6bb4d97f9c3ead0af4baaba167650f6610af596bba2b77a7510c1908218d8dc70e7ce8a7512637dedded487ef921f06c32c7e156be60d8c6911bfa917407c0d095eabd3f4cb711af56d9f58805bb1e76ae6cb9075/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep9-eng.srt&title-1=You%20S2%20Ep%209&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
});
mapRedirect(["you-s2-ep10"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 2 Episode 10 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/30d2d5ab6e859ea21368a2c59f97e4d2d85e6a802520698c134f11815080fd84a2061cacd488fb554c2e19662f4bf8d1dca3ee3a5ed783ae88c52dad1cc63b88f70338a9e0aa2a879f5a1cace65d8a4682ddeeac0faef643fd91174b9f3f862a5e857f30cadfc7856105d7c35436f71c929b34644e417ea822e7ca993cce55334e7588ae469cd329dfbe01dcdbca3ed6/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep10-eng.srt&title-1=You%20S2%20Ep%2010&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/30d2d5ab6e859ea21368a2c59f97e4d2d85e6a802520698c134f11815080fd84a2061cacd488fb554c2e19662f4bf8d1dca3ee3a5ed783ae88c52dad1cc63b88f70338a9e0aa2a879f5a1cace65d8a4682ddeeac0faef643fd91174b9f3f862a5e857f30cadfc7856105d7c35436f71c929b34644e417ea822e7ca993cce55334e7588ae469cd329dfbe01dcdbca3ed6/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s2-ep10-eng.srt&title-1=You%20S2%20Ep%2010&img=https://media.themoviedb.org/t/p/original/2NxnuOAwFl6ABoWRnE48iZ9QO9f.jpg",
});

// You Season 03
mapRedirect(["you-s3-ep1"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 3 Episode 1 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/de222e20e0ef74be60cf36d3c1f705abe1b07af85ccb729b1ed322c7e3e7b3a1ff2936b1c6b32f8bf6d03009e37e3b25ba7692bedeb1b5c58e9df1b55c8a90bc0e5e8037488b2a8aef206ac530c8243dd9003691bfabb651593bc4ff4221fe0fcad87a96b2376cf6b50665e2fedcc53ef0a7816dd04d3f0c88a4eeceab649973c194d4a2e84ff252b627d63693232ec8/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep1-eng.srt&title-1=You%20s3%20Ep%201&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/de222e20e0ef74be60cf36d3c1f705abe1b07af85ccb729b1ed322c7e3e7b3a1ff2936b1c6b32f8bf6d03009e37e3b25ba7692bedeb1b5c58e9df1b55c8a90bc0e5e8037488b2a8aef206ac530c8243dd9003691bfabb651593bc4ff4221fe0fcad87a96b2376cf6b50665e2fedcc53ef0a7816dd04d3f0c88a4eeceab649973c194d4a2e84ff252b627d63693232ec8/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep1-eng.srt&title-1=You%20s3%20Ep%201&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
});
mapRedirect(["you-s3-ep2"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 3 Episode 2 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/d0e215b7c7956ecfb7da7244c7c3d87725eed976d2a5c35042996ab13bc90e8839688ef1d15b7a7e2ab56f43d2f25ff653111ea12fc155aa763a63788c465ca7a9c4e4d0aba24239228010d12c3097ddf05f3b489314029dc5018a6170e0456eae51c494da67c3a26071b0dde52e3cb2b8009daa00e3231908c2d338c56c4a84/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep2-eng.srt&title-1=You%20s3%20Ep%202&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/d0e215b7c7956ecfb7da7244c7c3d87725eed976d2a5c35042996ab13bc90e8839688ef1d15b7a7e2ab56f43d2f25ff653111ea12fc155aa763a63788c465ca7a9c4e4d0aba24239228010d12c3097ddf05f3b489314029dc5018a6170e0456eae51c494da67c3a26071b0dde52e3cb2b8009daa00e3231908c2d338c56c4a84/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep2-eng.srt&title-1=You%20s3%20Ep%202&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
});
mapRedirect(["you-s3-ep3"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 3 Episode 3 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/bb5635890a4b983f6f25bc3b16c480ba0ae948d28ade2df648e2054616b4052c1b116ccc59c999a1684baf70cd07d4d9aef8f8390db48a9c515c9e5287876f07c0be633af5973cb3b477644fb6c2066992b2645e33dbbb1e980d6640f224dbbbf55bcfb0f2d8a6c22e77eba6663d871f6021dbdd4d59b2d14e6ea5ebaf529f99712d5b1d204d7a426f387b87b353b3c5/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep3-eng.srt&title-1=You%20s3%20Ep%203&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/bb5635890a4b983f6f25bc3b16c480ba0ae948d28ade2df648e2054616b4052c1b116ccc59c999a1684baf70cd07d4d9aef8f8390db48a9c515c9e5287876f07c0be633af5973cb3b477644fb6c2066992b2645e33dbbb1e980d6640f224dbbbf55bcfb0f2d8a6c22e77eba6663d871f6021dbdd4d59b2d14e6ea5ebaf529f99712d5b1d204d7a426f387b87b353b3c5/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep3-eng.srt&title-1=You%20s3%20Ep%203&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
});
mapRedirect(["you-s3-ep4"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 3 Episode 4 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/afb47b5681802dea6038b60967c2295699b9aae04a36086945ac3e00121acddbf454eff5a71fe8ff82a7e784a0c1c4c0f3f7a2c7d51f8c4e96fd0a6c2aef31d7e93ae4dbef651780ca2d99b0bb6ea9b925a673832916ad14a57a7a8a99aaef2f413370e257512e7e5cc3f3fb63da66d29689eff168e8f697aefcaec357ae08e166936ea7d2b9591f31f473204a7fd56f/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep4-eng.srt&title-1=You%20s3%20Ep%204&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/afb47b5681802dea6038b60967c2295699b9aae04a36086945ac3e00121acddbf454eff5a71fe8ff82a7e784a0c1c4c0f3f7a2c7d51f8c4e96fd0a6c2aef31d7e93ae4dbef651780ca2d99b0bb6ea9b925a673832916ad14a57a7a8a99aaef2f413370e257512e7e5cc3f3fb63da66d29689eff168e8f697aefcaec357ae08e166936ea7d2b9591f31f473204a7fd56f/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep4-eng.srt&title-1=You%20s3%20Ep%204&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
});
mapRedirect(["you-s3-ep5"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 3 Episode 5 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/0f1f0e7a9f209f4792506694655b7832533ec56a9e65aebe8b7bb6da4d1d7dfd080acc3470fe6e46d7cbadee50638a21ccd7016a3b0d7571ad76b98303c89863de4c5c9d75da4dce1922b96f4e3995d573e7f528bddcadf4883b849a1b2e6020d81f8b86ebc0c33aeb534320974ea9204dec5e04bda1526139da17349b1ba973288925d8cb1ec019bbb23e4eec2852f2/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep5-eng.srt&title-1=You%20s3%20Ep%205&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/0f1f0e7a9f209f4792506694655b7832533ec56a9e65aebe8b7bb6da4d1d7dfd080acc3470fe6e46d7cbadee50638a21ccd7016a3b0d7571ad76b98303c89863de4c5c9d75da4dce1922b96f4e3995d573e7f528bddcadf4883b849a1b2e6020d81f8b86ebc0c33aeb534320974ea9204dec5e04bda1526139da17349b1ba973288925d8cb1ec019bbb23e4eec2852f2/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep5-eng.srt&title-1=You%20s3%20Ep%205&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
});
mapRedirect(["you-s3-ep6"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 3 Episode 6 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/301f9e26681eb55c940a00f51afaf74a568b3daea419d0dcec2c77307832438c287cce2f19c14a26036c8b299ccc80d922e9dd497880cc9933e73c15dc94942822c2b19f6f53ff7d534ff5a537a2219315cb7c0a84b999fbc532e88d48a9df086f581a3899b8344d968d2a0469070c3100a08b3b2c5312f52dcc0b8236b6c99c5ec085010ba435778567446a8549fd22/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep6-eng.srt&title-1=You%20s3%20Ep%206&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/301f9e26681eb55c940a00f51afaf74a568b3daea419d0dcec2c77307832438c287cce2f19c14a26036c8b299ccc80d922e9dd497880cc9933e73c15dc94942822c2b19f6f53ff7d534ff5a537a2219315cb7c0a84b999fbc532e88d48a9df086f581a3899b8344d968d2a0469070c3100a08b3b2c5312f52dcc0b8236b6c99c5ec085010ba435778567446a8549fd22/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep6-eng.srt&title-1=You%20s3%20Ep%206&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
});
mapRedirect(["you-s3-ep7"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 3 Episode 7 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/7349acf36c13c86baf3b8bf6efcd280b445621f06ff1c0773cd3e2360759f4d19234da6e9bb26fdd6a60b57f4b3b6af03c602f5dc2101151e1ea616a47a0767af0ebeaef4f1d5c8351f3a4c3b906e29dd060e5eda6db7c70c27724558ee4fad263d7345a7d19c7d812d811f7e1f3421259a13d7963b642a0b3f4cdb9132bcdf8b0d01e1f7a891b4a8844aaddf91c13d9/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep7-eng.srt&title-1=You%20s3%20Ep%207&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/7349acf36c13c86baf3b8bf6efcd280b445621f06ff1c0773cd3e2360759f4d19234da6e9bb26fdd6a60b57f4b3b6af03c602f5dc2101151e1ea616a47a0767af0ebeaef4f1d5c8351f3a4c3b906e29dd060e5eda6db7c70c27724558ee4fad263d7345a7d19c7d812d811f7e1f3421259a13d7963b642a0b3f4cdb9132bcdf8b0d01e1f7a891b4a8844aaddf91c13d9/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep7-eng.srt&title-1=You%20s3%20Ep%207&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
});
mapRedirect(["you-s3-ep8"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 3 Episode 8 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/4c4b27747dcaa5f7d9e58f9a0a343ea53777f6233fc92e4c1490ef9574de1b494dd2e97ec698ea6b04570a1d9d84257bab49917ab38b249780c6d02949562e36c8bea47768157b515a4e179e2405e52e955ac94c54273913e5586b3f4404ab896982ca9c8d764a7c52bcc9fd541e8e7f29db07b8a37754a985f1cd7170db571dd1259eb2a90af15d2d62fbc7bc7d0403/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep8-eng.srt&title-1=You%20s3%20Ep%208&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/4c4b27747dcaa5f7d9e58f9a0a343ea53777f6233fc92e4c1490ef9574de1b494dd2e97ec698ea6b04570a1d9d84257bab49917ab38b249780c6d02949562e36c8bea47768157b515a4e179e2405e52e955ac94c54273913e5586b3f4404ab896982ca9c8d764a7c52bcc9fd541e8e7f29db07b8a37754a985f1cd7170db571dd1259eb2a90af15d2d62fbc7bc7d0403/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep8-eng.srt&title-1=You%20s3%20Ep%208&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
});
mapRedirect(["you-s3-ep9"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 3 Episode 9 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/28bf79669f7144036d3cfa1f403b4171b1cceca29c14a4694d24d54b07c6b9bf846279936c1fbd3049b0f4257b655f32c806cbba1f66f6e3d2bc204ae8a77d34258907826d63389f5ac388d4cfbf7e74f51a87833fb75a0e72a3c4a1a05fa2bd0e9342cd74cd08be9d44b4c039929ef28744dac23acde39041b261d0ca819611b521d915792f2ad4393290c8a38b98c9/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep9-eng.srt&title-1=You%20s3%20Ep%209&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/28bf79669f7144036d3cfa1f403b4171b1cceca29c14a4694d24d54b07c6b9bf846279936c1fbd3049b0f4257b655f32c806cbba1f66f6e3d2bc204ae8a77d34258907826d63389f5ac388d4cfbf7e74f51a87833fb75a0e72a3c4a1a05fa2bd0e9342cd74cd08be9d44b4c039929ef28744dac23acde39041b261d0ca819611b521d915792f2ad4393290c8a38b98c9/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep9-eng.srt&title-1=You%20s3%20Ep%209&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
});
mapRedirect(["you-s3-ep10"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 3 Episode 10 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/0272a931849c5617d3b486104f3478cbaf698d3864caccab1ce1f3acf298b865f1292e9c1c7a097b0500ff5b85dabc33652742ab68e161812926edadb38f215832bc1b265946ff1e58056a1b52d5fa3fc1eeec0e7f2b77fcc48000869f246c09996b564b01fe154fbaa15bc76d0e588c1d9830fd22690d4e6e8a329dba529b5f29072aeed79017f0c8b307b624fa2daf/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep10-eng.srt&title-1=You%20s3%20Ep%2010&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/0272a931849c5617d3b486104f3478cbaf698d3864caccab1ce1f3acf298b865f1292e9c1c7a097b0500ff5b85dabc33652742ab68e161812926edadb38f215832bc1b265946ff1e58056a1b52d5fa3fc1eeec0e7f2b77fcc48000869f246c09996b564b01fe154fbaa15bc76d0e588c1d9830fd22690d4e6e8a329dba529b5f29072aeed79017f0c8b307b624fa2daf/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s3-ep10-eng.srt&title-1=You%20s3%20Ep%2010&img=https://media.themoviedb.org/t/p/original/gzOIymABxmetAECXtazEYCpMmfb.jpg",
});

// You Season 04
mapRedirect(["you-s4-ep1"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 4 Episode 1 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/50124a3329eb994ff02238a07712be4f61a9fc178a67a5c0bb5a33d69934ad6b92069927317ff51d46c31306ebc9810de6d27b78f763028b0a5495f07c248fe97ccc31883b96d9644aadf824d04f161a2e73d5c997bb40fa117c5cca320691ce0473b2cc867e038d9da71d3901756ff2d06c1932ba1f6450a69d48585638c73041cfa634321f4908f105bef5f799c529/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep1-eng.srt&title-1=You%20s4%20Ep%201&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/50124a3329eb994ff02238a07712be4f61a9fc178a67a5c0bb5a33d69934ad6b92069927317ff51d46c31306ebc9810de6d27b78f763028b0a5495f07c248fe97ccc31883b96d9644aadf824d04f161a2e73d5c997bb40fa117c5cca320691ce0473b2cc867e038d9da71d3901756ff2d06c1932ba1f6450a69d48585638c73041cfa634321f4908f105bef5f799c529/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep1-eng.srt&title-1=You%20s4%20Ep%201&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
});
mapRedirect(["you-s4-ep2"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 4 Episode 2 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/d8dd321d56fb023cf6a1d186149ecc34c936cdd6d7b71228ba31db0b47017be45d7130e80e1a23da543472286eac8d8edefeb7cfe5202aeb5306dcfa7b42ce3123467f96875830805d1c80b092ca3cb2c7e9687368af01d5478de1f91558fc75e7205f526f5987434456535018146b6d67433585e96bcfc0032865b44e01f3495df00f81c0b11f31aeb70b00de4d8679/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep2-eng.srt&title-1=You%20s4%20Ep%202&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/d8dd321d56fb023cf6a1d186149ecc34c936cdd6d7b71228ba31db0b47017be45d7130e80e1a23da543472286eac8d8edefeb7cfe5202aeb5306dcfa7b42ce3123467f96875830805d1c80b092ca3cb2c7e9687368af01d5478de1f91558fc75e7205f526f5987434456535018146b6d67433585e96bcfc0032865b44e01f3495df00f81c0b11f31aeb70b00de4d8679/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep2-eng.srt&title-1=You%20s4%20Ep%202&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
});
mapRedirect(["you-s4-ep3"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 4 Episode 3 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/22f3e294259843f4be4eb26b35a6bebe20d2f1eb52bec51a241a7ba1a67f0c9ec4f2ddcbacefb0eb8d668f6b116380727cb182f81d2306f88c6ee9d38cee80e0f9b48939e7b0054f18ab2bdfe1b285fb5adc95c10135383007caf7708f0227e68db6fce251d9d03b96e9806a6a63852c0231513041c845f533abe423bfaa4a23c8b8186b96691064fe4c6b032d9787a2/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep3-eng.srt&title-1=You%20s4%20Ep%203&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/22f3e294259843f4be4eb26b35a6bebe20d2f1eb52bec51a241a7ba1a67f0c9ec4f2ddcbacefb0eb8d668f6b116380727cb182f81d2306f88c6ee9d38cee80e0f9b48939e7b0054f18ab2bdfe1b285fb5adc95c10135383007caf7708f0227e68db6fce251d9d03b96e9806a6a63852c0231513041c845f533abe423bfaa4a23c8b8186b96691064fe4c6b032d9787a2/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep3-eng.srt&title-1=You%20s4%20Ep%203&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
});
mapRedirect(["you-s4-ep4"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 4 Episode 4 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/c4ce59b9d3b1720ef66a2f66a30d660a89d1e4dbedba005e6dc0601cfe456ee005ac74b192228cd1d6a4637ede04d5e00795a297046a21dcd791d6553907e5a4773ba2031b0cb2a5388cb6930d920c4051afcd2a3598bf760886efb003f7ec4d051baee62b80eb66e3fbc934909455f8c1d81055d91bb0eb3d68e3868220a9c1d4e3f1a55012ae0f58b5d51e708f0952/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep4-eng.srt&title-1=You%20s4%20Ep%204&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/c4ce59b9d3b1720ef66a2f66a30d660a89d1e4dbedba005e6dc0601cfe456ee005ac74b192228cd1d6a4637ede04d5e00795a297046a21dcd791d6553907e5a4773ba2031b0cb2a5388cb6930d920c4051afcd2a3598bf760886efb003f7ec4d051baee62b80eb66e3fbc934909455f8c1d81055d91bb0eb3d68e3868220a9c1d4e3f1a55012ae0f58b5d51e708f0952/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep4-eng.srt&title-1=You%20s4%20Ep%204&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
});
mapRedirect(["you-s4-ep5"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 4 Episode 5 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/33442e0d0f57cf35d19d32689293b6e01d5b842b43863ca04f0eb4e0fcb1406e781c8977aca2f8558ed776df57b3e0c0b24e88de99989aa6dc82a24117f1caaabb341e40fc3594a4def444a472ab4e27c84654a4a4e728363d6b5ab94de1ad2f17a0cdab0061fff89feab9512914661f69897dfb057f57ae80fe073524bc38c021c9c3c0218ab74b0fdf9bf247c2f8c6/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep5-eng.srt&title-1=You%20s4%20Ep%205&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/33442e0d0f57cf35d19d32689293b6e01d5b842b43863ca04f0eb4e0fcb1406e781c8977aca2f8558ed776df57b3e0c0b24e88de99989aa6dc82a24117f1caaabb341e40fc3594a4def444a472ab4e27c84654a4a4e728363d6b5ab94de1ad2f17a0cdab0061fff89feab9512914661f69897dfb057f57ae80fe073524bc38c021c9c3c0218ab74b0fdf9bf247c2f8c6/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep5-eng.srt&title-1=You%20s4%20Ep%205&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
});
mapRedirect(["you-s4-ep6"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 4 Episode 6 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/ff869a8ef653d6e50834dee5385974bc758e9969dbfc675766a8d4288bfe2842014f83d506b94aca7383ac2a0462f1a6c8aab348e5cdde6cacfe3616a7b7aca95de862d7aed317825bb23f3a7c4515d57f801a8af4e25ff317515d4dc0263530cda05952536a5874ac51523514ccd40f9c461c0ae01881c27e3d1ff76addc387fd58e74d14a0a3b0659c0be32a299693/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep6-eng.srt&title-1=You%20s4%20Ep%206&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/ff869a8ef653d6e50834dee5385974bc758e9969dbfc675766a8d4288bfe2842014f83d506b94aca7383ac2a0462f1a6c8aab348e5cdde6cacfe3616a7b7aca95de862d7aed317825bb23f3a7c4515d57f801a8af4e25ff317515d4dc0263530cda05952536a5874ac51523514ccd40f9c461c0ae01881c27e3d1ff76addc387fd58e74d14a0a3b0659c0be32a299693/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep6-eng.srt&title-1=You%20s4%20Ep%206&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
});
mapRedirect(["you-s4-ep7"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 4 Episode 7 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/821de54b1f3c2c4ae6218b5e245ae4b121da59d3e91d8cc75c654c82d8fe9f28799b8c8c58123897f29a52700d79cade82c247bf0581b5fedd64b59213dc96098785784dd11bde945a7815fa2ab9396f2b15c29aa47aa513ffa41631fdde45c6da40d6dfe5a236b57991a9b71df36439efe80a65fcf0cbc49bf4cbe1509fba42ed85ae243c7855dc972f11b23bbb758a/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep7-eng.srt&title-1=You%20s4%20Ep%207&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/821de54b1f3c2c4ae6218b5e245ae4b121da59d3e91d8cc75c654c82d8fe9f28799b8c8c58123897f29a52700d79cade82c247bf0581b5fedd64b59213dc96098785784dd11bde945a7815fa2ab9396f2b15c29aa47aa513ffa41631fdde45c6da40d6dfe5a236b57991a9b71df36439efe80a65fcf0cbc49bf4cbe1509fba42ed85ae243c7855dc972f11b23bbb758a/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep7-eng.srt&title-1=You%20s4%20Ep%207&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
});
mapRedirect(["you-s4-ep8"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 4 Episode 8 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/a8fd62234098c36cbc92c6fb8257e809756c54d2d711ee5912d09a4b44f6d7196005fa1a28ba02567361db6ddfc81b7e53c83f7c0da9c56ec50ca8e422f05ad5a74cd59c0c0af1d5dd86cf92c55a190f88d7cf12f73994a452879808473f0dec3244270854dff7baf74ad5fd6270e3f81fe0417c2347b48ab7f653e2cd5c23e0187f6df123d840eb28cf20b9867d7d32/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep8-eng.srt&title-1=You%20s4%20Ep%208&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/a8fd62234098c36cbc92c6fb8257e809756c54d2d711ee5912d09a4b44f6d7196005fa1a28ba02567361db6ddfc81b7e53c83f7c0da9c56ec50ca8e422f05ad5a74cd59c0c0af1d5dd86cf92c55a190f88d7cf12f73994a452879808473f0dec3244270854dff7baf74ad5fd6270e3f81fe0417c2347b48ab7f653e2cd5c23e0187f6df123d840eb28cf20b9867d7d32/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep8-eng.srt&title-1=You%20s4%20Ep%208&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
});
mapRedirect(["you-s4-ep9"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 4 Episode 9 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/7f179d5712d7b757bb9e79465a8db12dfba054e8ee3f1e0f56e8f3e499e8cae138e07bb7db6811329cead40d2f0f92a6879ec94be8f02df3048c7ac80debee17890de42e88b95e8cc29b9a771d28fedae047b3e0638db15e9813ce08ba7a1b46e4a61e521a7300d42e876374b2bacec1547a6e6ea59548e1e3d74b657559f62451ae3de9fabbe9bc48b6b3d9f1c95da3/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep9-eng.srt&title-1=You%20s4%20Ep%209&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/7f179d5712d7b757bb9e79465a8db12dfba054e8ee3f1e0f56e8f3e499e8cae138e07bb7db6811329cead40d2f0f92a6879ec94be8f02df3048c7ac80debee17890de42e88b95e8cc29b9a771d28fedae047b3e0638db15e9813ce08ba7a1b46e4a61e521a7300d42e876374b2bacec1547a6e6ea59548e1e3d74b657559f62451ae3de9fabbe9bc48b6b3d9f1c95da3/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep9-eng.srt&title-1=You%20s4%20Ep%209&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
});
mapRedirect(["you-s4-ep10"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/2ZNFu0hkSVtAI6LRWGIlCPNd1Tj.jpg",
    title: "Watch You Season 4 Episode 10 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/9e349013d523f6396b8bfdf961c0f7b8d018de77a8afdce07d4ab7a28ebac26930db3f9b738d0c4c43ab30318e2826db06d399531f17975ca35755079f994cde5b79d7212b876d6bdd9432344a0289ca91018d013afc83d9240e3bc96d2b8e145a3594ad22bb6edd7ed67b9b1c07463861270ca146d37b7dc1d98a3ec35e404407878c27da78afbe7d083719118e9c05/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep10-eng.srt&title-1=You%20s4%20Ep%2010&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/9e349013d523f6396b8bfdf961c0f7b8d018de77a8afdce07d4ab7a28ebac26930db3f9b738d0c4c43ab30318e2826db06d399531f17975ca35755079f994cde5b79d7212b876d6bdd9432344a0289ca91018d013afc83d9240e3bc96d2b8e145a3594ad22bb6edd7ed67b9b1c07463861270ca146d37b7dc1d98a3ec35e404407878c27da78afbe7d083719118e9c05/playlist.m3u8&subcode=en&substitleurl=substitles/series/you/you-s4-ep10-eng.srt&title-1=You%20s4%20Ep%2010&img=https://media.themoviedb.org/t/p/original/xvKagY2nFulHsKvpK1d8YgB5VXT.jpg",
});

//Westworld Season 01
mapRedirect(["westworld-s1-ep1"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/d7Ssbqr0ifZhassIGjpfTaGNCzr.jpg",
    title: "Watch Westworld Season 1 Episode 1 with English Subtitle",
    video: "series.html?source=https://af.bigtimedelivery.net/_v13/0c86c6a4db8e1c9b429e00440d026d75ed6385e6fc7b50a6c77e6f6575bcbe4a41905459214e7ca1fd1e0029032548e1251ebe0ee77652959fd0145cb55dc2858a95189940f38e3725312ee18a0c54c531f2cc4aac42379db32e2c498a18c4c29756c6106348e79feedd973a545a27d6f379a0bd5bdaece3a14b09bc79ba27d5342b049c5af77ccf14c95a719afd0fc4/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep1-eng.srt&title-1=Westworld%20S1%20Ep%201&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
    video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/0c86c6a4db8e1c9b429e00440d026d75ed6385e6fc7b50a6c77e6f6575bcbe4a41905459214e7ca1fd1e0029032548e1251ebe0ee77652959fd0145cb55dc2858a95189940f38e3725312ee18a0c54c531f2cc4aac42379db32e2c498a18c4c29756c6106348e79feedd973a545a27d6f379a0bd5bdaece3a14b09bc79ba27d5342b049c5af77ccf14c95a719afd0fc4/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep1-eng.srt&title-1=Westworld%20S1%20Ep%201&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
});
mapRedirect(["westworld-s1-ep2"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/d7Ssbqr0ifZhassIGjpfTaGNCzr.jpg",
    title: "Watch Westworld Season 1 Episode 2 with English Subtitle",
    video: "series.html?source=https://af.bigtimedelivery.net/_v13/1d98dae9be82c3ac468e19054585e863b15334f8a9354f0773cd2f726bf5d299522bc0b6c9af5fe9aec3e7393b431f4453103b757a36810021c6866e45562a90942afc957795bd545fc40dd4066907909739f6e313fe884ee8dae48d7c9e2f31ad71954e9a49eca6cd86799e4197f95ad25f939cefc345582d0eaa7abc5f5d5c843ce69fc0118b5225f37da60091ab80/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep2-eng.srt&title-1=Westworld%20S1%20Ep%202&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
    video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/1d98dae9be82c3ac468e19054585e863b15334f8a9354f0773cd2f726bf5d299522bc0b6c9af5fe9aec3e7393b431f4453103b757a36810021c6866e45562a90942afc957795bd545fc40dd4066907909739f6e313fe884ee8dae48d7c9e2f31ad71954e9a49eca6cd86799e4197f95ad25f939cefc345582d0eaa7abc5f5d5c843ce69fc0118b5225f37da60091ab80/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep2-eng.srt&title-1=Westworld%20S1%20Ep%202&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
});
mapRedirect(["westworld-s1-ep3"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/d7Ssbqr0ifZhassIGjpfTaGNCzr.jpg",
    title: "Watch Westworld Season 1 Episode 3 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/817b262e2d62a3fffb6618ccf3bdc7696d6cc57ff07a438365f46c77f04b78ef5ad9f4bc510e38ba4e474a24087ed8177e92e975599a54650be7ecb7b074b00cac19af08d97d90d8296225f881ef83889a16574557d94a0269542de5882975121ceb29b5e77719ebfdcea776007ce2c0e417a357b46b7c3da9913ba5a31fbd64a3e537975d7d43fe1c701e4e3e88cd76/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep3-eng.srt&title-1=Westworld%20S1%20Ep%203&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/817b262e2d62a3fffb6618ccf3bdc7696d6cc57ff07a438365f46c77f04b78ef5ad9f4bc510e38ba4e474a24087ed8177e92e975599a54650be7ecb7b074b00cac19af08d97d90d8296225f881ef83889a16574557d94a0269542de5882975121ceb29b5e77719ebfdcea776007ce2c0e417a357b46b7c3da9913ba5a31fbd64a3e537975d7d43fe1c701e4e3e88cd76/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep3-eng.srt&title-1=Westworld%20S1%20Ep%203&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
});
mapRedirect(["westworld-s1-ep4"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/d7Ssbqr0ifZhassIGjpfTaGNCzr.jpg",
    title: "Watch Westworld Season 1 Episode 4 with English Subtitle",
    video: "series.html?source=https://ac.bigtimedelivery.net/_v13/75f20bd4bee260acc6216dbf649b136da9344218ed192de127178bd7484b0b3f1626e2176375e36c5c9f59b63077cd752b2f7d4b93edc72a93d73d5ef5e1c5b9edab2379897c3dce0707aa7d170d8c681ef6fee38e339eabefecea9ccdcca323a2a0e0a2b5a49c29563da2df4baf4563c4295080c85b80cf9dae02ed37e88961183b78efd30fb5810753a6ec6b89a7d5/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep4-eng.srt&title-1=Westworld%20S1%20Ep%204&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
    video2: "series2.html?source=https://ac.bigtimedelivery.net/_v13/75f20bd4bee260acc6216dbf649b136da9344218ed192de127178bd7484b0b3f1626e2176375e36c5c9f59b63077cd752b2f7d4b93edc72a93d73d5ef5e1c5b9edab2379897c3dce0707aa7d170d8c681ef6fee38e339eabefecea9ccdcca323a2a0e0a2b5a49c29563da2df4baf4563c4295080c85b80cf9dae02ed37e88961183b78efd30fb5810753a6ec6b89a7d5/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep4-eng.srt&title-1=Westworld%20S1%20Ep%204&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
});
mapRedirect(["westworld-s1-ep5"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/d7Ssbqr0ifZhassIGjpfTaGNCzr.jpg",
    title: "Watch Westworld Season 1 Episode 5 with English Subtitle",
    video: "series.html?source=https://ai.bigtimedelivery.net/_v13/d007b7c9e060b4d1d5924537967367950809561ce747c4fac5116a242bb12c7c6d4ce85dfecaf588baf59220acdc5e9d92ce4d688bb4b174e1bff1f2ba153551818cbad178bb7487488f38f415b41a0dc629312a2e502a39dd548f31559737bbe2a0d4a3d4dfb8ecdaecb536a285969e6b6320921ed6148e24d8775baa97b218869ca39ccb34ab0779fabba7c5c5c072/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep5-eng.srt&title-1=Westworld%20S1%20Ep%205&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
    video2: "series2.html?source=https://ai.bigtimedelivery.net/_v13/d007b7c9e060b4d1d5924537967367950809561ce747c4fac5116a242bb12c7c6d4ce85dfecaf588baf59220acdc5e9d92ce4d688bb4b174e1bff1f2ba153551818cbad178bb7487488f38f415b41a0dc629312a2e502a39dd548f31559737bbe2a0d4a3d4dfb8ecdaecb536a285969e6b6320921ed6148e24d8775baa97b218869ca39ccb34ab0779fabba7c5c5c072/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep5-eng.srt&title-1=Westworld%20S1%20Ep%205&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
});
mapRedirect(["westworld-s1-ep6"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/d7Ssbqr0ifZhassIGjpfTaGNCzr.jpg",
    title: "Watch Westworld Season 1 Episode 6 with English Subtitle",
    video: "series.html?source=https://aj.bigtimedelivery.net/_v13/0390cda294625a297b863f971a3ddfcc6a2ac815d8729a4564b0879474d10cb736d2418e7d46a22c9dca14309a073deff97ee759e1af19bd5519e41668c1dd7dc72060732419106573922c3c17b504f6504c0e154a14deb1187a9c924ae1b59973d33f3b1dac51981740a33fba25aa59a841cd56df0a885e4bf96286797914207486ca40b6cc8e77714716e8a0f565d0/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep6-eng.srt&title-1=Westworld%20S1%20Ep%206&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
    video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/0390cda294625a297b863f971a3ddfcc6a2ac815d8729a4564b0879474d10cb736d2418e7d46a22c9dca14309a073deff97ee759e1af19bd5519e41668c1dd7dc72060732419106573922c3c17b504f6504c0e154a14deb1187a9c924ae1b59973d33f3b1dac51981740a33fba25aa59a841cd56df0a885e4bf96286797914207486ca40b6cc8e77714716e8a0f565d0/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep6-eng.srt&title-1=Westworld%20S1%20Ep%206&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
});
mapRedirect(["westworld-s1-ep7"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/d7Ssbqr0ifZhassIGjpfTaGNCzr.jpg",
    title: "Watch Westworld Season 1 Episode 7 with English Subtitle",
    video: "series.html?source=https://ac.bigtimedelivery.net/_v13/94b56e84985bea7a195cb1821865111ff13e0301358cf3b2548987d02b903f4b5cc100b87b96c10f8c23109ae90c53bce257e26cc837fb44be3a84b7a27b798fd8d3c60e0a9459e1abc74a6b520b326084c9af97f04b4eb8106b546a56e57a341ff7fc2ef70702ccb2949e59a8af5563935218953cb24d0b6299489d868bf753dbe6df4b9019d6695dab8032b2714fa1/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep7-eng.srt&title-1=Westworld%20S1%20Ep%207&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
    video2: "series2.html?source=https://ac.bigtimedelivery.net/_v13/94b56e84985bea7a195cb1821865111ff13e0301358cf3b2548987d02b903f4b5cc100b87b96c10f8c23109ae90c53bce257e26cc837fb44be3a84b7a27b798fd8d3c60e0a9459e1abc74a6b520b326084c9af97f04b4eb8106b546a56e57a341ff7fc2ef70702ccb2949e59a8af5563935218953cb24d0b6299489d868bf753dbe6df4b9019d6695dab8032b2714fa1/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep7-eng.srt&title-1=Westworld%20S1%20Ep%207&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
});
mapRedirect(["westworld-s1-ep8"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/d7Ssbqr0ifZhassIGjpfTaGNCzr.jpg",
    title: "Watch Westworld Season 1 Episode 8 with English Subtitle",
    video: "series.html?source=https://ac.bigtimedelivery.net/_v13/ee1f23b7f6493737570dfffaebe8e085242b8da1268a44f48b3064870fec2afbc02d4b4df540d793c1c8a2362b5a92876fc7a664b5e1c0c514f289dc0362c7c21a36f5d0f2b881fa0c82653eed72bbb4c3119e57466e3b8baf05d9899c6ea63fc9bada41167e574f560e09af86ab22adfb9519f0ef9d6507b56082dacd66ef84ef3a27c9005e0a0bdd68e8cacef39cd8/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep8-eng.srt&title-1=Westworld%20S1%20Ep%208&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
    video2: "series.html?source=https://ac.bigtimedelivery.net/_v13/ee1f23b7f6493737570dfffaebe8e085242b8da1268a44f48b3064870fec2afbc02d4b4df540d793c1c8a2362b5a92876fc7a664b5e1c0c514f289dc0362c7c21a36f5d0f2b881fa0c82653eed72bbb4c3119e57466e3b8baf05d9899c6ea63fc9bada41167e574f560e09af86ab22adfb9519f0ef9d6507b56082dacd66ef84ef3a27c9005e0a0bdd68e8cacef39cd8/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep8-eng.srt&title-1=Westworld%20S1%20Ep%208&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
});
mapRedirect(["westworld-s1-ep9"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/d7Ssbqr0ifZhassIGjpfTaGNCzr.jpg",
    title: "Watch Westworld Season 1 Episode 9 with English Subtitle",
    video2: "series2.html?source=https://ai.bigtimedelivery.net/_v13/467c3752d1e9158b7d88b620427bb81728678a84fdd7c1250e966016e637bbb63a967249e280caa0509ed3eafc9a0d2efb5b295a852f776cfa04237421f9ea6805e787dad8140340d29ae6fe9ef07b8bf927b52dd78c1e553e1b12ba09e0895bd36029b214f4314db22f324b390791daeec57869e60d4960bbf6210dd0bbd5e3cc0c6ce0a1630bd9e98b3b2a922ffd34/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep9-eng.srt&title-1=Westworld%20S1%20Ep%209&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
    video: "series.html?source=https://ai.bigtimedelivery.net/_v13/467c3752d1e9158b7d88b620427bb81728678a84fdd7c1250e966016e637bbb63a967249e280caa0509ed3eafc9a0d2efb5b295a852f776cfa04237421f9ea6805e787dad8140340d29ae6fe9ef07b8bf927b52dd78c1e553e1b12ba09e0895bd36029b214f4314db22f324b390791daeec57869e60d4960bbf6210dd0bbd5e3cc0c6ce0a1630bd9e98b3b2a922ffd34/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep9-eng.srt&title-1=Westworld%20S1%20Ep%209&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
});
mapRedirect(["westworld-s1-ep10"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/d7Ssbqr0ifZhassIGjpfTaGNCzr.jpg",
    title: "Watch Westworld Season 1 Episode 10 with English Subtitle",
    video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/a3ddd2241855cafb3792ad1db2ce1cf45b29beb69fe293d8e4f2e62a912f9b452af5170d77da22d0349aedd20a13546ce565b1f9c9457056c56d525080d473a12c3946e76d976caeff44f5e7db831224358eea77fd7bc39821e01d08cc317957d1464fca26396314eec12f70a2932c229952e9f42a07a84f046e79b27a092e13431819db71c541066213e228791c0285/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep10-eng.srt&title-1=Westworld%20S1%20Ep%2010&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
    video: "series.html?source=https://af.bigtimedelivery.net/_v13/a3ddd2241855cafb3792ad1db2ce1cf45b29beb69fe293d8e4f2e62a912f9b452af5170d77da22d0349aedd20a13546ce565b1f9c9457056c56d525080d473a12c3946e76d976caeff44f5e7db831224358eea77fd7bc39821e01d08cc317957d1464fca26396314eec12f70a2932c229952e9f42a07a84f046e79b27a092e13431819db71c541066213e228791c0285/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s1-ep10-eng.srt&title-1=Westworld%20S1%20Ep%2010&img=https://image.tmdb.org/t/p/original/6FNFL3Rh96TAS5dBvYzuTAtN2Df.jpg",
});

// Westworld Season 02
mapRedirect(["westworld-s2-ep1"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lxa7CfnpU0kwPRX0Ifz5GjAD5yj.jpg",
    title: "Watch Westworld Season 2 Episode 1 with English Subtitle",
    video: "series.html?source=https://af.bigtimedelivery.net/_v13/15cde87b25151f540e4242aafd2726e5b35a399733056e1d94e86959fc40b31f346cab87b23ff54967a6bca38f3fff78c2be1106a7edddc1fd15945e9c738de8f9bbdcd19e35b5d23d53545f5656cef33fa9340ea98119700de0843321b3a6d03fdf24d7f1cb669516f3c273a729f358cfcd92e8f0f3d0b7c0fbf236d73778d2eccffb6b7a362fd18e4a34ce0e02f343/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep1-eng.srt&title-1=Westworld%20S2%20Ep%201&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
    video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/15cde87b25151f540e4242aafd2726e5b35a399733056e1d94e86959fc40b31f346cab87b23ff54967a6bca38f3fff78c2be1106a7edddc1fd15945e9c738de8f9bbdcd19e35b5d23d53545f5656cef33fa9340ea98119700de0843321b3a6d03fdf24d7f1cb669516f3c273a729f358cfcd92e8f0f3d0b7c0fbf236d73778d2eccffb6b7a362fd18e4a34ce0e02f343/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep1-eng.srt&title-1=Westworld%20S2%20Ep%201&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
});
mapRedirect(["westworld-s2-ep2"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lxa7CfnpU0kwPRX0Ifz5GjAD5yj.jpg",
    title: "Watch Westworld Season 2 Episode 2 with English Subtitle",
    video: "series.html?source=https://ah.bigtimedelivery.net/_v13/db1dbe0b99580ac967b9b0f07b24895dc56f9b72e3529e0fb95b4aad386f1704085fd48cdbf9ea60d8b56c659fcf2ad3ba947a8d09bed3ed8b7609d868ff33dd3bf5bb9af47e88a9091cb6c932629e6127b0a7843746a3a8db24d509304db34f6d133a03c6fc6e90c535021f1834fafdd12a5a6e503f877e7a91a87353a731af7f3c0000b3c11d281eb18473357d23c5/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep2-eng.srt&title-1=Westworld%20S2%20Ep%202&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
    video2: "series2.html?source=https://ah.bigtimedelivery.net/_v13/db1dbe0b99580ac967b9b0f07b24895dc56f9b72e3529e0fb95b4aad386f1704085fd48cdbf9ea60d8b56c659fcf2ad3ba947a8d09bed3ed8b7609d868ff33dd3bf5bb9af47e88a9091cb6c932629e6127b0a7843746a3a8db24d509304db34f6d133a03c6fc6e90c535021f1834fafdd12a5a6e503f877e7a91a87353a731af7f3c0000b3c11d281eb18473357d23c5/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep2-eng.srt&title-1=Westworld%20S2%20Ep%202&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
});
mapRedirect(["westworld-s2-ep3"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lxa7CfnpU0kwPRX0Ifz5GjAD5yj.jpg",
    title: "Watch Westworld Season 2 Episode 3 with English Subtitle",
    video: "series.html?source=https://ah.bigtimedelivery.net/_v13/db1dbe0b99580ac967b9b0f07b24895dc56f9b72e3529e0fb95b4aad386f1704085fd48cdbf9ea60d8b56c659fcf2ad3ba947a8d09bed3ed8b7609d868ff33dd3bf5bb9af47e88a9091cb6c932629e6127b0a7843746a3a8db24d509304db34f6d133a03c6fc6e90c535021f1834fafdd12a5a6e503f877e7a91a87353a731af7f3c0000b3c11d281eb18473357d23c5/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep3-eng.srt&title-1=Westworld%20S2%20Ep%203&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
    video2: "series2.html?source=https://ah.bigtimedelivery.net/_v13/db1dbe0b99580ac967b9b0f07b24895dc56f9b72e3529e0fb95b4aad386f1704085fd48cdbf9ea60d8b56c659fcf2ad3ba947a8d09bed3ed8b7609d868ff33dd3bf5bb9af47e88a9091cb6c932629e6127b0a7843746a3a8db24d509304db34f6d133a03c6fc6e90c535021f1834fafdd12a5a6e503f877e7a91a87353a731af7f3c0000b3c11d281eb18473357d23c5/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep3-eng.srt&title-1=Westworld%20S2%20Ep%203&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
});
mapRedirect(["westworld-s2-ep4"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lxa7CfnpU0kwPRX0Ifz5GjAD5yj.jpg",
    title: "Watch Westworld Season 2 Episode 4 with English Subtitle",
    video: "series.html?source=https://ab.bigtimedelivery.net/_v13/8ab7b4e0f9db365d2fcf4f45682c464d7b6597fd6ce0fcc37c16030d2fb2627d29d306e119869ba9c2998a8e360a147cec3155878297cc7de8dd250ad60cfb7c48339af896b009fdc7d29875bc3b5a811228f8213fb7a6ceb7f798dbc12a5914ac01acc1d68c73d4283ddc870790276ab8c0108ac109c02789af3aaf30fce628ce18d2b2ea505f80131254aa1287d987/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep4-eng.srt&title-1=Westworld%20S2%20Ep%204&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
    video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/8ab7b4e0f9db365d2fcf4f45682c464d7b6597fd6ce0fcc37c16030d2fb2627d29d306e119869ba9c2998a8e360a147cec3155878297cc7de8dd250ad60cfb7c48339af896b009fdc7d29875bc3b5a811228f8213fb7a6ceb7f798dbc12a5914ac01acc1d68c73d4283ddc870790276ab8c0108ac109c02789af3aaf30fce628ce18d2b2ea505f80131254aa1287d987/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep4-eng.srt&title-1=Westworld%20S2%20Ep%204&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
});
mapRedirect(["westworld-s2-ep5"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lxa7CfnpU0kwPRX0Ifz5GjAD5yj.jpg",
    title: "Watch Westworld Season 2 Episode 5 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/0fcf72ecd1aa689d26e9f97438fc7d221cb492779c9ca87112d35e9bd1e20b97b789e1e61927cb5454239a1fc4ec5341726c3aed1258aba4c2b95a6b099292390e40533c6a3038a46d6a994430f597240b49681bbfcc1fbc29014432fd1ce50a4b746f8945dcb88c10056e191e90546bf0c70351777774a20cbd6e63d0af672c54cd17a6acc03e5530cde8f59989c0e1/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep5-eng.srt&title-1=Westworld%20S2%20Ep%205&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/0fcf72ecd1aa689d26e9f97438fc7d221cb492779c9ca87112d35e9bd1e20b97b789e1e61927cb5454239a1fc4ec5341726c3aed1258aba4c2b95a6b099292390e40533c6a3038a46d6a994430f597240b49681bbfcc1fbc29014432fd1ce50a4b746f8945dcb88c10056e191e90546bf0c70351777774a20cbd6e63d0af672c54cd17a6acc03e5530cde8f59989c0e1/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep5-eng.srt&title-1=Westworld%20S2%20Ep%205&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
});
mapRedirect(["westworld-s2-ep6"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lxa7CfnpU0kwPRX0Ifz5GjAD5yj.jpg",
    title: "Watch Westworld Season 2 Episode 6 with English Subtitle",
    video: "series.html?source=https://af.bigtimedelivery.net/_v13/938c720e30bf633692bd7d256f6d0957a14854eed6356bc83ab6ecdb00fb31681e39f8c3af4dc46f49ce343d13d88ba7d6aa2b38d22cb801fa354b59dfd67eb1f164507d108e65d8047440ab6a53cb27f392a93bff612b5572f35efc55985dcbaf2e69b01a05d60debcd7a13913fcd88bd6f5913d0bfc7d9d492d623f14d1773f188867d2c8ede7c33889656359d517c/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep6-eng.srt&title-1=Westworld%20S2%20Ep%206&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
    video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/938c720e30bf633692bd7d256f6d0957a14854eed6356bc83ab6ecdb00fb31681e39f8c3af4dc46f49ce343d13d88ba7d6aa2b38d22cb801fa354b59dfd67eb1f164507d108e65d8047440ab6a53cb27f392a93bff612b5572f35efc55985dcbaf2e69b01a05d60debcd7a13913fcd88bd6f5913d0bfc7d9d492d623f14d1773f188867d2c8ede7c33889656359d517c/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep6-eng.srt&title-1=Westworld%20S2%20Ep%206&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
});
mapRedirect(["westworld-s2-ep7"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lxa7CfnpU0kwPRX0Ifz5GjAD5yj.jpg",
    title: "Watch Westworld Season 2 Episode 7 with English Subtitle",
    video: "series.html?source=https://af.bigtimedelivery.net/_v13/315f109800ae5a24d2ba257ae80e00971796f8732c5bd55c3ec1b11863512db65c3a446b8942114dd913bd4d02e6cbecfc9555d722380b5fd625cd0d0f705b9320d8264969dd8858a79f1dd827d8604537f21da5b90d9d63e2cc91565e16601595dd04c3d6a7f4ffc9e62c172430ee09c00b8fa549230d8c86a0279c1c1da55f29d0b4151e733cc5587fab1fe762a864/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep7-eng.srt&title-1=Westworld%20S2%20Ep%207&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
    video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/315f109800ae5a24d2ba257ae80e00971796f8732c5bd55c3ec1b11863512db65c3a446b8942114dd913bd4d02e6cbecfc9555d722380b5fd625cd0d0f705b9320d8264969dd8858a79f1dd827d8604537f21da5b90d9d63e2cc91565e16601595dd04c3d6a7f4ffc9e62c172430ee09c00b8fa549230d8c86a0279c1c1da55f29d0b4151e733cc5587fab1fe762a864/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep7-eng.srt&title-1=Westworld%20S2%20Ep%207&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
});
mapRedirect(["westworld-s2-ep8"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lxa7CfnpU0kwPRX0Ifz5GjAD5yj.jpg",
    title: "Watch Westworld Season 2 Episode 8 with English Subtitle",
    video: "series.html?source=https://aj.bigtimedelivery.net/_v13/1fc3b60d2091441ad028e66cba2ee8c2e1e114fdf8b71dca3b1ba68926632ec784b37af38a29b18227160e30efc95b5ded7f507d440e565e41f0b14d010f0889eff3944cdcb0cf60d203b22afe4657abd8f78ef656d76abcd872c1caae553aacf8748ec5d3332e225d96dbe20a9c0e7c6736f133e18dddeaa164c96dbb364e2e715fc05a3c588796ec27ea7e7e1e00d6/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep8-eng.srt&title-1=Westworld%20S2%20Ep%208&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
    video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/1fc3b60d2091441ad028e66cba2ee8c2e1e114fdf8b71dca3b1ba68926632ec784b37af38a29b18227160e30efc95b5ded7f507d440e565e41f0b14d010f0889eff3944cdcb0cf60d203b22afe4657abd8f78ef656d76abcd872c1caae553aacf8748ec5d3332e225d96dbe20a9c0e7c6736f133e18dddeaa164c96dbb364e2e715fc05a3c588796ec27ea7e7e1e00d6/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep8-eng.srt&title-1=Westworld%20S2%20Ep%208&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
});
mapRedirect(["westworld-s2-ep9"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lxa7CfnpU0kwPRX0Ifz5GjAD5yj.jpg",
    title: "Watch Westworld Season 2 Episode 9 with English Subtitle",
    video: "series.html?source=https://af.bigtimedelivery.net/_v13/e3fa179cbc0ae68652b03d1cd13515565af64c6c637e6d8ad2ae9d802dd29edd3ca1bf3ccd8c755eeea6b4fff2bce2e70610336a6ca1f48f5081ae122ce41b08080294d33012523dd8eb9f582a2380c41446618fdbe7df6fe9a317cc4ae8bd908cbcc64281ff8587b40bc9a11bf09b39ed9b0d01a4f3b640571d2944ab7c94256c58a69c2a2afc27e2c6c2cc83520398/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep9-eng.srt&title-1=Westworld%20S2%20Ep%209&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
    video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/e3fa179cbc0ae68652b03d1cd13515565af64c6c637e6d8ad2ae9d802dd29edd3ca1bf3ccd8c755eeea6b4fff2bce2e70610336a6ca1f48f5081ae122ce41b08080294d33012523dd8eb9f582a2380c41446618fdbe7df6fe9a317cc4ae8bd908cbcc64281ff8587b40bc9a11bf09b39ed9b0d01a4f3b640571d2944ab7c94256c58a69c2a2afc27e2c6c2cc83520398/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep9-eng.srt&title-1=Westworld%20S2%20Ep%209&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
});
mapRedirect(["westworld-s2-ep10"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lxa7CfnpU0kwPRX0Ifz5GjAD5yj.jpg",
    title: "Watch Westworld Season 2 Episode 10 with English Subtitle",
    video: "series.html?source=https://ab.bigtimedelivery.net/_v13/16b81a6d5babf3a11d5b1d688c24b997bbb2eaefffabd2fe90b88d046f20493ba10adaea9dc6be58b57311a41816fe7efaaef3b29eb5e251e091c4b685c80df1c63270284eb98fa95c0c47346a8b1e3db3c401df94676572635d07d699a402670fc053cee0ede1906975bf6615cd6fcb5e7be823c9629460b26751a63fb96885d558cb569b1f93730b4d81eee5526271/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep10-eng.srt&title-1=Westworld%20S2%20Ep%2010&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
    video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/16b81a6d5babf3a11d5b1d688c24b997bbb2eaefffabd2fe90b88d046f20493ba10adaea9dc6be58b57311a41816fe7efaaef3b29eb5e251e091c4b685c80df1c63270284eb98fa95c0c47346a8b1e3db3c401df94676572635d07d699a402670fc053cee0ede1906975bf6615cd6fcb5e7be823c9629460b26751a63fb96885d558cb569b1f93730b4d81eee5526271/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s2-ep10-eng.srt&title-1=Westworld%20S2%20Ep%2010&img=https://image.tmdb.org/t/p/original/oL6Brye00Oz9Uz16lHMrnzzwXq4.jpg",
});

// Westworld Season 03
mapRedirect(["westworld-s3-ep1"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/kCcwJiNVp155xV6yQHvD2YPq792.jpg",
    title: "Watch Westworld Season 3 Episode 1 with English Subtitle",
    video: "series.html?source=https://ai.bigtimedelivery.net/_v13/68d676e45bea6b90d73e74a08c51783aca4c7e840c596632c8044e344a119d6bd121b9eada4835129e63fbb4b9d7f2bdc1280be12eaa518e44b9308499049e5c88a4b34eed38c8963709a71fd638106c210288cf0353b845b8907185c3b01674a96da60c55628c58e2e876fcc7379d64a2dcf079f26efe6c3bfb97f7fe6ef73a08c1776c985f0856c6431bcbc1574642/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep1-eng.srt&title-1=Westworld%20s3%20Ep%201&img=https://image.tmdb.org/t/p/original/v6laDZZ9Vl3vhkDad7ko50v5tZg.jpg",
    video2: "series2.html?source=https://ai.bigtimedelivery.net/_v13/68d676e45bea6b90d73e74a08c51783aca4c7e840c596632c8044e344a119d6bd121b9eada4835129e63fbb4b9d7f2bdc1280be12eaa518e44b9308499049e5c88a4b34eed38c8963709a71fd638106c210288cf0353b845b8907185c3b01674a96da60c55628c58e2e876fcc7379d64a2dcf079f26efe6c3bfb97f7fe6ef73a08c1776c985f0856c6431bcbc1574642/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep1-eng.srt&title-1=Westworld%20s3%20Ep%201&img=https://image.tmdb.org/t/p/original/v6laDZZ9Vl3vhkDad7ko50v5tZg.jpg",
});
mapRedirect(["westworld-s3-ep2"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/kCcwJiNVp155xV6yQHvD2YPq792.jpg",
    title: "Watch Westworld Season 3 Episode 2 with English Subtitle",
    video: "series.html?source=https://aa.bigtimedelivery.net/_v13/92001773637c7d23bb6dbef8e736d89bc6197775f98d838efe0c2a57b468e07edf4a1dbf8e2dcdb11533ce91e46204f3bbe15cf2a18231bc756ae9f1e6383b45d1ec4f792036028b0116b60dde5a32285022d98b2502dc7187c21fae0580fad2f56534fcee5b1f23a5401152c95c2347b191619f9ed3be46ffab3b136a667faf7392013732f9aae548b108fe87302dde/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep2-eng.srt&title-1=Westworld%20s3%20Ep%202&img=https://image.tmdb.org/t/p/original/v6laDZZ9Vl3vhkDad7ko50v5tZg.jpg",
    video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/92001773637c7d23bb6dbef8e736d89bc6197775f98d838efe0c2a57b468e07edf4a1dbf8e2dcdb11533ce91e46204f3bbe15cf2a18231bc756ae9f1e6383b45d1ec4f792036028b0116b60dde5a32285022d98b2502dc7187c21fae0580fad2f56534fcee5b1f23a5401152c95c2347b191619f9ed3be46ffab3b136a667faf7392013732f9aae548b108fe87302dde/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep2-eng.srt&title-1=Westworld%20s3%20Ep%202&img=https://image.tmdb.org/t/p/original/v6laDZZ9Vl3vhkDad7ko50v5tZg.jpg",
});
mapRedirect(["westworld-s3-ep3"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/kCcwJiNVp155xV6yQHvD2YPq792.jpg",
    title: "Watch Westworld Season 3 Episode 3 with English Subtitle",
    video: "series.html?source=https://aj.bigtimedelivery.net/_v13/58716f0f5ac72f61aa9f96175df776b3400358074e4cb5d0bcd0d0de5e73225b52193c44457c3e3a9b78e3fe18f8151a55d4c2d6fa575458aa879675bc209d9d3c2802f604761c4e55b118cb18bf02b3a569fd3119320cea7f2c43fb92c6d61000382d6c25d616c5820ef8c461ddd333093718aaf7d106b5a3ca5db5f3b3eb3feb7be5c16e204d1d44e2e43ea7a2865e/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep3-eng.srt&title-1=Westworld%20s3%20Ep%203&img=https://image.tmdb.org/t/p/original/v6laDZZ9Vl3vhkDad7ko50v5tZg.jpg",
    video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/58716f0f5ac72f61aa9f96175df776b3400358074e4cb5d0bcd0d0de5e73225b52193c44457c3e3a9b78e3fe18f8151a55d4c2d6fa575458aa879675bc209d9d3c2802f604761c4e55b118cb18bf02b3a569fd3119320cea7f2c43fb92c6d61000382d6c25d616c5820ef8c461ddd333093718aaf7d106b5a3ca5db5f3b3eb3feb7be5c16e204d1d44e2e43ea7a2865e/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep3-eng.srt&title-1=Westworld%20s3%20Ep%203&img=https://image.tmdb.org/t/p/original/v6laDZZ9Vl3vhkDad7ko50v5tZg.jpg",
});
mapRedirect(["westworld-s3-ep4"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/kCcwJiNVp155xV6yQHvD2YPq792.jpg",
    title: "Watch Westworld Season 3 Episode 4 with English Subtitle",
    video: "series.html?source=https://af.bigtimedelivery.net/_v13/316df081779b873c8683bc3170e754b914916c0c0f59edb80d4d9cde42c0a9dfd4d8b61d86bcc27926be9fc807be16cbab015ece1d2eb941ad27506066ede1cc1ea883c321cfd2a84c83c0c3687027c0177e69d716c114abdd6567fbd868787dfc762dc8ba0766bb344720041a2801dc200898da1e4d25aba3d846ab984e8fd8c44f0277b3c405c4356953a78e9e6531/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep4-eng.srt&title-1=Westworld%20s3%20Ep%204&img=https://image.tmdb.org/t/p/original/gVigzBMoBSNVyg4We1bPBcK695D.jpg",
    video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/316df081779b873c8683bc3170e754b914916c0c0f59edb80d4d9cde42c0a9dfd4d8b61d86bcc27926be9fc807be16cbab015ece1d2eb941ad27506066ede1cc1ea883c321cfd2a84c83c0c3687027c0177e69d716c114abdd6567fbd868787dfc762dc8ba0766bb344720041a2801dc200898da1e4d25aba3d846ab984e8fd8c44f0277b3c405c4356953a78e9e6531/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep4-eng.srt&title-1=Westworld%20s3%20Ep%204&img=https://image.tmdb.org/t/p/original/gVigzBMoBSNVyg4We1bPBcK695D.jpg",
});
mapRedirect(["westworld-s3-ep5"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/kCcwJiNVp155xV6yQHvD2YPq792.jpg",
    title: "Watch Westworld Season 3 Episode 5 with English Subtitle",
    video: "series.html?source=https://ae.bigtimedelivery.net/_v13/3ce1708577db3f0859d771a13f4560fb48afde4535969295c3058678bbeb31b6f8bfeff3baaa891828218cdab65b60d7848d83334826ee89f07480a3ddad566e4921409fc7e02f0bcda87217e3569bea590121b91b28d6abc490ebfd1d8ecb7cc74a7c69c30c398d372b8617b0465e69eab36eb4054691b228404be86e83e7dd5d38df413d33a7cba64c5fcc1c59681d/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep5-eng.srt&title-1=Westworld%20s3%20Ep%205&img=https://image.tmdb.org/t/p/original/gVigzBMoBSNVyg4We1bPBcK695D.jpg",
    video2: "series2.html?source=https://ae.bigtimedelivery.net/_v13/3ce1708577db3f0859d771a13f4560fb48afde4535969295c3058678bbeb31b6f8bfeff3baaa891828218cdab65b60d7848d83334826ee89f07480a3ddad566e4921409fc7e02f0bcda87217e3569bea590121b91b28d6abc490ebfd1d8ecb7cc74a7c69c30c398d372b8617b0465e69eab36eb4054691b228404be86e83e7dd5d38df413d33a7cba64c5fcc1c59681d/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep5-eng.srt&title-1=Westworld%20s3%20Ep%205&img=https://image.tmdb.org/t/p/original/gVigzBMoBSNVyg4We1bPBcK695D.jpg",
});
mapRedirect(["westworld-s3-ep6"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/kCcwJiNVp155xV6yQHvD2YPq792.jpg",
    title: "Watch Westworld Season 3 Episode 6 with English Subtitle",
    video: "series.html?source=https://ag.bigtimedelivery.net/_v13/76c5ee6d6f659fdc8d6a776ae34f7045a12c13406039579e732a11dca0db419fb171a94937b7a769b57a9156c7574bb6e8a022d7ca2642f808b22d98fdc35ae12514add149d5fda5ae56da85997c81faadf5437173f15832e2c972d3d7d9df2a55c13b88217ba573c7f76c70a4432610b06c93daa02a8098d01451cc7835b66304578fcf48e57f6b3e3ca7e1eab72b05/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep6-eng.srt&title-1=Westworld%20s3%20Ep%206&img=https://image.tmdb.org/t/p/original/gVigzBMoBSNVyg4We1bPBcK695D.jpg",
    video2: "series2.html?source=https://ag.bigtimedelivery.net/_v13/76c5ee6d6f659fdc8d6a776ae34f7045a12c13406039579e732a11dca0db419fb171a94937b7a769b57a9156c7574bb6e8a022d7ca2642f808b22d98fdc35ae12514add149d5fda5ae56da85997c81faadf5437173f15832e2c972d3d7d9df2a55c13b88217ba573c7f76c70a4432610b06c93daa02a8098d01451cc7835b66304578fcf48e57f6b3e3ca7e1eab72b05/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep6-eng.srt&title-1=Westworld%20s3%20Ep%206&img=https://image.tmdb.org/t/p/original/gVigzBMoBSNVyg4We1bPBcK695D.jpg",
});
mapRedirect(["westworld-s3-ep7"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/kCcwJiNVp155xV6yQHvD2YPq792.jpg",
    title: "Watch Westworld Season 3 Episode 7 with English Subtitle",
    video: "series.html?source=https://ag.bigtimedelivery.net/_v13/be748b6e60ce8f34d5f922d100ce5f52c2e876ae61295a2456ec445ee9bc19d80a779e346095790d63f2b9608a8c391e7309419ba7101243306d38d85abf950292e40bedde9349896626cd5f196030153f68b430ac2969c92f2fc64b777a8624b6b7e5cf5d809ff0d568957df79ce120a6d404303a935861218ca3a41bf4a5e12f7ec27c8fc062dac4bc22bccee58e11/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep7-eng.srt&title-1=Westworld%20s3%20Ep%207&img=https://image.tmdb.org/t/p/original/lWFRCNrmY2bHX6aVkodJGQVFqoC.jpg",
    video2: "series2.html?source=https://ag.bigtimedelivery.net/_v13/be748b6e60ce8f34d5f922d100ce5f52c2e876ae61295a2456ec445ee9bc19d80a779e346095790d63f2b9608a8c391e7309419ba7101243306d38d85abf950292e40bedde9349896626cd5f196030153f68b430ac2969c92f2fc64b777a8624b6b7e5cf5d809ff0d568957df79ce120a6d404303a935861218ca3a41bf4a5e12f7ec27c8fc062dac4bc22bccee58e11/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep7-eng.srt&title-1=Westworld%20s3%20Ep%207&img=https://image.tmdb.org/t/p/original/lWFRCNrmY2bHX6aVkodJGQVFqoC.jpg",
});
mapRedirect(["westworld-s3-ep8"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/kCcwJiNVp155xV6yQHvD2YPq792.jpg",
    title: "Watch Westworld Season 3 Episode 8 with English Subtitle",
    video: "series.html?source=https://ab.bigtimedelivery.net/_v13/04617c6f27b6bff1b5a169d2f43933b53d4ce8cd53ac912122e87a7eeeec709c7f46f1f534ce58cbbd9ff445cd3d8be70cc70a7efd2a8fb60b5a434f81682a91b329f9ff8641de60157e2e3fc873bf5e47db8cf49eb338dde46df67da0263570454944e38f5806c083cdf48fbecda74b0d0960ea75e239aa4383d72cadbf0206f49acf790a9d23451c75e12796904cb3/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep8-eng.srt&title-1=Westworld%20s3%20Ep%208&img=https://image.tmdb.org/t/p/original/lWFRCNrmY2bHX6aVkodJGQVFqoC.jpg",
    video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/04617c6f27b6bff1b5a169d2f43933b53d4ce8cd53ac912122e87a7eeeec709c7f46f1f534ce58cbbd9ff445cd3d8be70cc70a7efd2a8fb60b5a434f81682a91b329f9ff8641de60157e2e3fc873bf5e47db8cf49eb338dde46df67da0263570454944e38f5806c083cdf48fbecda74b0d0960ea75e239aa4383d72cadbf0206f49acf790a9d23451c75e12796904cb3/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s3-ep8-eng.srt&title-1=Westworld%20s3%20Ep%208&img=https://image.tmdb.org/t/p/original/lWFRCNrmY2bHX6aVkodJGQVFqoC.jpg",
});

// Westworld Season 04
mapRedirect(["westworld-s4-ep1"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lyu7jz9qcUOpa5PaY2lDbOrsYx1.jpg",
    title: "Watch Westworld Season 4 Episode 1 with English Subtitle",
    video: "series.html?source=https://ab.bigtimedelivery.net/_v13/e592ef0d10af85dc5504b7d5a1926869c4b39783165456fe17a0bd89ece53a94139219e53814436dc215fad316ff4baff82e804ae35ea44cd12506af5a2642a7ac894e8a2af23f2747890c5243d7b1471b6f34a00055d4ac26a86175b3521b9ab326ced036375000fae4cacb2a71c8f6237221ed9f05b7173591a759507be8f13c741f140b5c69aafa2eeb7bb6c053f7/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep1-eng.srt&title-1=Westworld%20s4%20Ep%201&img=https://image.tmdb.org/t/p/original/GUjT9FqefQGW5IPJDtOxx1Rone.jpg",
    video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/e592ef0d10af85dc5504b7d5a1926869c4b39783165456fe17a0bd89ece53a94139219e53814436dc215fad316ff4baff82e804ae35ea44cd12506af5a2642a7ac894e8a2af23f2747890c5243d7b1471b6f34a00055d4ac26a86175b3521b9ab326ced036375000fae4cacb2a71c8f6237221ed9f05b7173591a759507be8f13c741f140b5c69aafa2eeb7bb6c053f7/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep1-eng.srt&title-1=Westworld%20s4%20Ep%201&img=https://image.tmdb.org/t/p/original/GUjT9FqefQGW5IPJDtOxx1Rone.jpg",
});
mapRedirect(["westworld-s4-ep2"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lyu7jz9qcUOpa5PaY2lDbOrsYx1.jpg",
    title: "Watch Westworld Season 4 Episode 2 with English Subtitle",
    video: "series.html?source=https://ah.bigtimedelivery.net/_v13/d72eea8d0c6b5f2641aa33a6472626f5f00d6ffa2ad5c3f382cd8f26d16fd41bc1ad5a0a4cedea8b434f9a7f8596073b493080807e03b5bbfbe2d6c2d45e567aaed3623a6156e86cba63af3b43532188641158539085c8c3a3970cd7293a536c9c1f1de89e9856757c99ca94cc47cecf3cfe95b4604fd215ee948b97fd36ff1888723fa2a88bd7fa98317a00bb9328e1/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep2-eng.srt&title-1=Westworld%20s4%20Ep%202&img=https://image.tmdb.org/t/p/original/GUjT9FqefQGW5IPJDtOxx1Rone.jpg",
    video2: "series2.html?source=https://ah.bigtimedelivery.net/_v13/d72eea8d0c6b5f2641aa33a6472626f5f00d6ffa2ad5c3f382cd8f26d16fd41bc1ad5a0a4cedea8b434f9a7f8596073b493080807e03b5bbfbe2d6c2d45e567aaed3623a6156e86cba63af3b43532188641158539085c8c3a3970cd7293a536c9c1f1de89e9856757c99ca94cc47cecf3cfe95b4604fd215ee948b97fd36ff1888723fa2a88bd7fa98317a00bb9328e1/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep2-eng.srt&title-1=Westworld%20s4%20Ep%202&img=https://image.tmdb.org/t/p/original/GUjT9FqefQGW5IPJDtOxx1Rone.jpg",
});
mapRedirect(["westworld-s4-ep3"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lyu7jz9qcUOpa5PaY2lDbOrsYx1.jpg",
    title: "Watch Westworld Season 4 Episode 3 with English Subtitle",
    video: "series.html?source=https://aa.bigtimedelivery.net/_v13/25c1749204685eb9e415ed25d643534a155b0fa7bf0e3f5ae1966ac12330ef63bd86228c2e51e328b5f1efe314fa996ca95134e337a1ef0f1bb0ec6ea13f1b66acc6bfcf71e86642b53db0a35aed836eda440702871952813185c7df3f1025050d4e6e324dc1cf621c2209319fb17b612337f2a1744f676b0ddd7f90c7690def7b86c7506cf1b72821148a01595476d1/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep3-eng.srt&title-1=Westworld%20s4%20Ep%203&img=https://image.tmdb.org/t/p/original/GUjT9FqefQGW5IPJDtOxx1Rone.jpg",
    video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/25c1749204685eb9e415ed25d643534a155b0fa7bf0e3f5ae1966ac12330ef63bd86228c2e51e328b5f1efe314fa996ca95134e337a1ef0f1bb0ec6ea13f1b66acc6bfcf71e86642b53db0a35aed836eda440702871952813185c7df3f1025050d4e6e324dc1cf621c2209319fb17b612337f2a1744f676b0ddd7f90c7690def7b86c7506cf1b72821148a01595476d1/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep3-eng.srt&title-1=Westworld%20s4%20Ep%203&img=https://image.tmdb.org/t/p/original/GUjT9FqefQGW5IPJDtOxx1Rone.jpg",
});
mapRedirect(["westworld-s4-ep4"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lyu7jz9qcUOpa5PaY2lDbOrsYx1.jpg",
    title: "Watch Westworld Season 4 Episode 4 with English Subtitle",
    video: "series.html?source=https://ae.bigtimedelivery.net/_v13/517f020cb0081bff73ea56e0d0cd06711b600b3ad0dc6667efcb375441e398f7c488d6758fbcab701466e5bbaacda056d6973467403f6be972fc082672d6bbd5bcd964454e23ef6e2ee3a047d72e8558b6f750be9aa213ae8e8c646e88548a46cd4751259ebb16e4f21e166122eb230a24d7620407b0ea00cc73ae3d2354f93f6b4ec4dcb80d9728e2c908d1f7a39f7d/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep4-eng.srt&title-1=Westworld%20s4%20Ep%204&img=https://image.tmdb.org/t/p/original/2iKUOeA7KfP5iMD7IXWYkSw4a6t.jpg",
    video2: "series2.html?source=https://ae.bigtimedelivery.net/_v13/517f020cb0081bff73ea56e0d0cd06711b600b3ad0dc6667efcb375441e398f7c488d6758fbcab701466e5bbaacda056d6973467403f6be972fc082672d6bbd5bcd964454e23ef6e2ee3a047d72e8558b6f750be9aa213ae8e8c646e88548a46cd4751259ebb16e4f21e166122eb230a24d7620407b0ea00cc73ae3d2354f93f6b4ec4dcb80d9728e2c908d1f7a39f7d/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep4-eng.srt&title-1=Westworld%20s4%20Ep%204&img=https://image.tmdb.org/t/p/original/2iKUOeA7KfP5iMD7IXWYkSw4a6t.jpg",
});
mapRedirect(["westworld-s4-ep5"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lyu7jz9qcUOpa5PaY2lDbOrsYx1.jpg",
    title: "Watch Westworld Season 4 Episode 5 with English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/bb2e92b049ac625e272638b7dd4dcb8dbab644b7fd2732a02bd686c5501706dc4e94777ddc200db0822e47b09f3d561b016b9c4b432ad1ac87ed649146076c041eb524943295818028d8816004cc7f138bd7c8572bb8cfe6a2c1d346774e8a80e9318d43252a9940e0f298995262ce1d5a37223d2b7a2a3e1f6645ec0c8538649bb3e8e9e145e3ad96bdd225b836dda5/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep5-eng.srt&title-1=Westworld%20s4%20Ep%205&img=https://image.tmdb.org/t/p/original/2iKUOeA7KfP5iMD7IXWYkSw4a6t.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/bb2e92b049ac625e272638b7dd4dcb8dbab644b7fd2732a02bd686c5501706dc4e94777ddc200db0822e47b09f3d561b016b9c4b432ad1ac87ed649146076c041eb524943295818028d8816004cc7f138bd7c8572bb8cfe6a2c1d346774e8a80e9318d43252a9940e0f298995262ce1d5a37223d2b7a2a3e1f6645ec0c8538649bb3e8e9e145e3ad96bdd225b836dda5/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep5-eng.srt&title-1=Westworld%20s4%20Ep%205&img=https://image.tmdb.org/t/p/original/2iKUOeA7KfP5iMD7IXWYkSw4a6t.jpg",
});
mapRedirect(["westworld-s4-ep6"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lyu7jz9qcUOpa5PaY2lDbOrsYx1.jpg",
    title: "Watch Westworld Season 4 Episode 6 with English Subtitle",
    video: "series.html?source=https://ac.bigtimedelivery.net/_v13/cd8d035316de70700dbb1e3663f164d3f330076d93b9b1648cfaac9e43e7c871337eacc85b705a0fd81b9cd8dde15549bade1a91c39ed31f825c864380d88a76ceb8ddc75823451b9df39066c3a04dea7660d34cac5a389833dd0ed055f2f607042df1be54a39442060f745685008ca900532a01b39c54b3a4fbaf9b64275839e39c3ba925adafd3bb4d4c91679df512/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep6-eng.srt&title-1=Westworld%20s4%20Ep%206&img=https://image.tmdb.org/t/p/original/2iKUOeA7KfP5iMD7IXWYkSw4a6t.jpg",
    video2: "series2.html?source=https://ac.bigtimedelivery.net/_v13/cd8d035316de70700dbb1e3663f164d3f330076d93b9b1648cfaac9e43e7c871337eacc85b705a0fd81b9cd8dde15549bade1a91c39ed31f825c864380d88a76ceb8ddc75823451b9df39066c3a04dea7660d34cac5a389833dd0ed055f2f607042df1be54a39442060f745685008ca900532a01b39c54b3a4fbaf9b64275839e39c3ba925adafd3bb4d4c91679df512/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep6-eng.srt&title-1=Westworld%20s4%20Ep%206&img=https://image.tmdb.org/t/p/original/2iKUOeA7KfP5iMD7IXWYkSw4a6t.jpg",
});
mapRedirect(["westworld-s4-ep7"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lyu7jz9qcUOpa5PaY2lDbOrsYx1.jpg",
    title: "Watch Westworld Season 4 Episode 7 with English Subtitle",
    video: "series.html?source=https://af.bigtimedelivery.net/_v13/e93f7e298a17dff1dceb026526a0153fefc5db152924b22e8b10d8b37acb2c51cb68a878d48c7efc5f9b2f5b70c04606f6ae6543581bd2b651df2875d5bca446bfc34f6177016891ffe7e97489a774c2c56605b29d534d9e3e2be579588ae71b4fc661bfbf3618b0b2135c204e658ee61ca16a768946ad0f768e941394f4c2f9da1ed2be4a0c13e5beafedb3b1bf4ec5/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep7-eng.srt&title-1=Westworld%20s4%20Ep%207&img=https://image.tmdb.org/t/p/original/k3aYo9nBjuc67pHWQCvgRcTk8xW.jpg",
    video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/e93f7e298a17dff1dceb026526a0153fefc5db152924b22e8b10d8b37acb2c51cb68a878d48c7efc5f9b2f5b70c04606f6ae6543581bd2b651df2875d5bca446bfc34f6177016891ffe7e97489a774c2c56605b29d534d9e3e2be579588ae71b4fc661bfbf3618b0b2135c204e658ee61ca16a768946ad0f768e941394f4c2f9da1ed2be4a0c13e5beafedb3b1bf4ec5/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep7-eng.srt&title-1=Westworld%20s4%20Ep%207&img=https://image.tmdb.org/t/p/original/k3aYo9nBjuc67pHWQCvgRcTk8xW.jpg",
});
mapRedirect(["westworld-s4-ep8"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lyu7jz9qcUOpa5PaY2lDbOrsYx1.jpg",
    title: "Watch Westworld Season 4 Episode 8 with English Subtitle",
    video: "series.html?source=https://ab.bigtimedelivery.net/_v13/ff13813a13212174489cd589ffd08b6144cb3efbf2b0912cabbae9b9af3b05b2d1cc21a99f84453d82573ccf879bd058313baae3671dd5815130c150032e09e10048c7e6142266dd6ac5d84f13bc7dbf3697412895380e8096fceac8011e26a8517f22d72a7ebe508632123436d2a6cdf19e8cf8d21bd44cecc9e68f56ea2e13697b81a6915100592e7286229b5dfd99/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep8-eng.srt&title-1=Westworld%20s4%20Ep%208&img=https://image.tmdb.org/t/p/original/k3aYo9nBjuc67pHWQCvgRcTk8xW.jpg",
    video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/ff13813a13212174489cd589ffd08b6144cb3efbf2b0912cabbae9b9af3b05b2d1cc21a99f84453d82573ccf879bd058313baae3671dd5815130c150032e09e10048c7e6142266dd6ac5d84f13bc7dbf3697412895380e8096fceac8011e26a8517f22d72a7ebe508632123436d2a6cdf19e8cf8d21bd44cecc9e68f56ea2e13697b81a6915100592e7286229b5dfd99/playlist.m3u8&subcode=en&substitleurl=substitles/series/westworld/westworld-s4-ep8-eng.srt&title-1=Westworld%20s4%20Ep%208&img=https://image.tmdb.org/t/p/original/k3aYo9nBjuc67pHWQCvgRcTk8xW.jpg",
});


//Alice in borderland Season 1 Hindi Dubbed
mapRedirect(["alice-in-borderland-hindi-s1-ep1"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 1 Episode 1 hindi dubbed",
    video: "https://drive.google.com/file/d/1-Owv5LBNbX-EFydatEygbGkfwNpn2Dmu/preview",
    video2: "https://drive.google.com/file/d/1-Owv5LBNbX-EFydatEygbGkfwNpn2Dmu/preview",
});
mapRedirect(["alice-in-borderland-hindi-s1-ep2"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 1 Episode 2 hindi dubbed",
    video: "https://drive.google.com/file/d/1-4UjOnn_UllUQ4dMrssJFzetGQJsSrf0/preview",
    video2: "https://drive.google.com/file/d/1-4UjOnn_UllUQ4dMrssJFzetGQJsSrf0/preview",
});
mapRedirect(["alice-in-borderland-hindi-s1-ep3"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 1 Episode 3 hindi dubbed",
    video: "https://drive.google.com/file/d/1-6jMdm9OJtllydsb5ibnHAo1URqVPF4q/preview",
    video2: "https://drive.google.com/file/d/1-6jMdm9OJtllydsb5ibnHAo1URqVPF4q/preview",
});
mapRedirect(["alice-in-borderland-hindi-s1-ep4"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 1 Episode 4 hindi dubbed",
    video: "https://drive.google.com/file/d/1-0unsWQO1NTYpXQXOL0eNJpiTSVMR5xi/preview",
    video2: "https://drive.google.com/file/d/1-0unsWQO1NTYpXQXOL0eNJpiTSVMR5xi/preview",
});
mapRedirect(["alice-in-borderland-hindi-s1-ep5"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 1 Episode 5 hindi dubbed",
    video: "https://drive.google.com/file/d/1yPeqYwa1SchsBO9knntgCGh7IOC-Zo44/preview",
    video2: "https://drive.google.com/file/d/1yPeqYwa1SchsBO9knntgCGh7IOC-Zo44/preview",
});
mapRedirect(["alice-in-borderland-hindi-s1-ep6"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 1 Episode 6 hindi dubbed",
    video: "https://drive.google.com/file/d/1--H80lB5sNuhHqbxl44_8CybYr-8F1D7/preview",
    video2: "https://drive.google.com/file/d/1--H80lB5sNuhHqbxl44_8CybYr-8F1D7/preview",
});
mapRedirect(["alice-in-borderland-hindi-s1-ep7"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 1 Episode 7 hindi dubbed",
    video: "https://drive.google.com/file/d/1-BJ32YA4i842QwUWi4UewvMlkrnNOZ95/preview",
    video2: "https://drive.google.com/file/d/1-BJ32YA4i842QwUWi4UewvMlkrnNOZ95/preview",
});
mapRedirect(["alice-in-borderland-hindi-s1-ep8"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 1 Episode 8 hindi dubbed",
    video: "https://drive.google.com/file/d/19KCYdpC1XUfJuN7uN4mtbXlmATG3Lrct/preview",
    video2: "https://drive.google.com/file/d/19KCYdpC1XUfJuN7uN4mtbXlmATG3Lrct/preview",
});

//Alice in borderland Season 2 Hindi Dubbed
mapRedirect(["alice-in-borderland-hindi-s2-ep1"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 2 Episode 1 hindi dubbed",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8glhak",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8glhak",
});
mapRedirect(["alice-in-borderland-hindi-s2-ep2"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 2 Episode 2 hindi dubbed",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8glkqg",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8glkqg",
});
mapRedirect(["alice-in-borderland-hindi-s2-ep3"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 2 Episode 3 hindi dubbed",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8gll55",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8gll55",
});
mapRedirect(["alice-in-borderland-hindi-s2-ep4"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 2 Episode 4 hindi dubbed",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8glz5a",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8glz5a",
});
mapRedirect(["alice-in-borderland-hindi-s2-ep5"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 2 Episode 5 hindi dubbed",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8gmepe",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8gmepe",
});
mapRedirect(["alice-in-borderland-hindi-s2-ep6"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 2 Episode 6 hindi dubbed",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8gmgn6",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8gmgn6",
});
mapRedirect(["alice-in-borderland-hindi-s2-ep7"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 2 Episode 7 hindi dubbed",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8gmhym",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8gmhym",
});
mapRedirect(["alice-in-borderland-hindi-s2-ep8"], {
    splashimgurl: "https://media.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg",
    title: "Watch Alice in borderland Season 2 Episode 8 hindi dubbed",
    video: "https://geo.dailymotion.com/player/x1bog.html?video=x8gmjeq",
    video2: "https://geo.dailymotion.com/player/x1bog.html?video=x8gmjeq",
});

//Kerala Crime Files
mapRedirect(["kerala-crime-files-ep1"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/o0bLjzFk6h7EOg9ubcL02m3tdlu.jpg",
    title: "Watch Kerala Crime Files Episode 1",
    video: "https://cdn.asumanaksoy.com/video/7f3ad9c65beb20ccbd34a05041b4420b",
    video2: "https://cdn.asumanaksoy.com/video/7f3ad9c65beb20ccbd34a05041b4420b",
});
mapRedirect(["kerala-crime-files-ep2"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/o0bLjzFk6h7EOg9ubcL02m3tdlu.jpg",
    title: "Watch Kerala Crime Files Episode 2",
    video: "https://cdn.asumanaksoy.com/video/3a24b25a7b092a252166a1641ae953e7",
    video2: "https://cdn.asumanaksoy.com/video/3a24b25a7b092a252166a1641ae953e7",
});
mapRedirect(["kerala-crime-files-ep3"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/o0bLjzFk6h7EOg9ubcL02m3tdlu.jpg",
    title: "Watch Kerala Crime Files Episode 3",
    video: "https://cdn.asumanaksoy.com/video/b56ea7b6aa77f6f9008bc9362fab3597",
    video2: "https://cdn.asumanaksoy.com/video/b56ea7b6aa77f6f9008bc9362fab3597",
});
mapRedirect(["kerala-crime-files-ep4"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/o0bLjzFk6h7EOg9ubcL02m3tdlu.jpg",
    title: "Watch Kerala Crime Files Episode 4",
    video: "https://cdn.asumanaksoy.com/video/567b8f5f423af15818a068235807edc0",
    video2: "https://cdn.asumanaksoy.com/video/567b8f5f423af15818a068235807edc0",
});
mapRedirect(["kerala-crime-files-ep5"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/o0bLjzFk6h7EOg9ubcL02m3tdlu.jpg",
    title: "Watch Kerala Crime Files Episode 5",
    video: "https://cdn.asumanaksoy.com/video/317d17f10845da500bcf49780b7f35bf",
    video2: "https://cdn.asumanaksoy.com/video/317d17f10845da500bcf49780b7f35bf",
});
mapRedirect(["kerala-crime-files-ep6"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/o0bLjzFk6h7EOg9ubcL02m3tdlu.jpg",
    title: "Watch Kerala Crime Files Episode 6",
    video: "https://cdn.asumanaksoy.com/video/317d17f10845da500bcf49780b7f35bf",
    video2: "https://cdn.asumanaksoy.com/video/317d17f10845da500bcf49780b7f35bf",
});

//The Signal

mapRedirect(["the-signal-s1-ep1"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/tMWT0JvPwxsNFN4rbvUb6lFv6Pz.jpg",
    title: "Watch The Signal Season 1 Episode 1",
    video: "series.html?source=https://aj.bigtimedelivery.net/_v13/34cd84be538a5dd7b215181abd91049ece009d7e120c87f2aa16a8db654f62e1f94a3807def4fb4855f26a46c190bb3677cb706c22c92c3563e569d0ba93499d616e07f456f32ac1d1ce508c81fd0a4cfe6dbba0ea035f42a00f64308ba571de64ab3100c6c926b45c12136341c0263a9d818d39a0e2281b20c51a181737f6b91f7277d001532947d46acf5fc8a602ec/playlist.m3u8&subcode=en&substitleurl=substitles/series/the-signal/the-signal-s1-ep1-en.srt&title-1=The Signal S1 EP1&img=https://image.tmdb.org/t/p/original/9jt0k9x8vHfMI49G3mmYP9eYn0h.jpg",
    video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/34cd84be538a5dd7b215181abd91049ece009d7e120c87f2aa16a8db654f62e1f94a3807def4fb4855f26a46c190bb3677cb706c22c92c3563e569d0ba93499d616e07f456f32ac1d1ce508c81fd0a4cfe6dbba0ea035f42a00f64308ba571de64ab3100c6c926b45c12136341c0263a9d818d39a0e2281b20c51a181737f6b91f7277d001532947d46acf5fc8a602ec/playlist.m3u8&subcode=en&substitleurl=substitles/series/the-signal/the-signal-s1-ep1-en.srt&title-1=The Signal S1 EP1&img=https://image.tmdb.org/t/p/original/9jt0k9x8vHfMI49G3mmYP9eYn0h.jpg",
});
mapRedirect(["the-signal-s1-ep2"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/tMWT0JvPwxsNFN4rbvUb6lFv6Pz.jpg",
    title: "Watch The Signal Season 1 Episode 2",
    video: "series.html?source=https://af.bigtimedelivery.net/_v13/3a71465b7fe90fde6eea508dbbf7c055b548bd6c4fc0f02ce8c816974600f6ae2f0ccc7af526badffc9de6228b95d26012b9bb9fafe84883cab29388f459666ea966309dfa3f6ab812d66b29127464307b7afbc7aa7fbd9518e9bce795fa07701c19299f85e818ec1a81d6ef9416964a8fed8423babcad0dcbf0e9c5349b90428a49bb157c66a9f95a576910316f3be4/playlist.m3u8&subcode=en&substitleurl=substitles/series/the-signal/the-signal-s1-ep2-en.srt&title-1=The Signal S1 Ep2&img=https://image.tmdb.org/t/p/original/9jt0k9x8vHfMI49G3mmYP9eYn0h.jpg",
    video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/3a71465b7fe90fde6eea508dbbf7c055b548bd6c4fc0f02ce8c816974600f6ae2f0ccc7af526badffc9de6228b95d26012b9bb9fafe84883cab29388f459666ea966309dfa3f6ab812d66b29127464307b7afbc7aa7fbd9518e9bce795fa07701c19299f85e818ec1a81d6ef9416964a8fed8423babcad0dcbf0e9c5349b90428a49bb157c66a9f95a576910316f3be4/playlist.m3u8&subcode=en&substitleurl=substitles/series/the-signal/the-signal-s1-ep2-en.srt&title-1=The Signal S1 Ep2&img=https://image.tmdb.org/t/p/original/9jt0k9x8vHfMI49G3mmYP9eYn0h.jpg",
});
mapRedirect(["the-signal-s1-ep3"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/tMWT0JvPwxsNFN4rbvUb6lFv6Pz.jpg",
    title: "Watch The Signal Season 1 Episode 3",
    video: "series.html?source=https://af.bigtimedelivery.net/_v13/2eb27a8d1edce377ead960fe1d4cb3662168a7f3b6a75bc528f2ab5265dc389a027c80b1278a41e969aa78505382564edb45247f0ab467a86406bc0f1297bc7f59dc195ccec29561db389da70a72f9886a8c74f7203dc85f2a57402228f7c770fca164bd6c9f53ea5b6bac6cdfae2fbe0c8b52cc6fb7bf837b6bd26317573a44db9509d7f0ff6747aa22df5bfdb8a083/playlist.m3u8&subcode=en&substitleurl=substitles/series/the-signal/the-signal-s1-ep3-en.srt&title-1=The Signal S1 EP3&img=https://image.tmdb.org/t/p/original/9jt0k9x8vHfMI49G3mmYP9eYn0h.jpg",
    video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/2eb27a8d1edce377ead960fe1d4cb3662168a7f3b6a75bc528f2ab5265dc389a027c80b1278a41e969aa78505382564edb45247f0ab467a86406bc0f1297bc7f59dc195ccec29561db389da70a72f9886a8c74f7203dc85f2a57402228f7c770fca164bd6c9f53ea5b6bac6cdfae2fbe0c8b52cc6fb7bf837b6bd26317573a44db9509d7f0ff6747aa22df5bfdb8a083/playlist.m3u8&subcode=en&substitleurl=substitles/series/the-signal/the-signal-s1-ep3-en.srt&title-1=The Signal S1 EP3&img=https://image.tmdb.org/t/p/original/9jt0k9x8vHfMI49G3mmYP9eYn0h.jpg",
});
mapRedirect(["the-signal-s1-ep4"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/tMWT0JvPwxsNFN4rbvUb6lFv6Pz.jpg",
    title: "Watch The Signal Season 1 Episode 4",
    video: "series.html?source=https://ag.bigtimedelivery.net/_v13/8b23d5aaa6c4cd3f0c0498a665146d47a4ed2f00ff647603a4373ee832081bad5d7374efd1939af98d129c1a58f484bdc979ac8ae482b236bffc380b427ec658c0f0927b559d43db7d30d011c43b45e22e84e3bc21130326f0a645ef41f3f8b24eec8f22f3a35e4326ad7f4e677f8d8481430117cbb892d2ddd7e19ea0ddbdb7fdb6b0778f2982a08aeb96e6fdca6e2e/playlist.m3u8&subcode=en&substitleurl=substitles/series/the-signal/the-signal-s1-ep4-en.srt&title-1=The Signal S1 EP4&img=https://image.tmdb.org/t/p/original/9jt0k9x8vHfMI49G3mmYP9eYn0h.jpg",
    video2: "series2.html?source=https://ag.bigtimedelivery.net/_v13/8b23d5aaa6c4cd3f0c0498a665146d47a4ed2f00ff647603a4373ee832081bad5d7374efd1939af98d129c1a58f484bdc979ac8ae482b236bffc380b427ec658c0f0927b559d43db7d30d011c43b45e22e84e3bc21130326f0a645ef41f3f8b24eec8f22f3a35e4326ad7f4e677f8d8481430117cbb892d2ddd7e19ea0ddbdb7fdb6b0778f2982a08aeb96e6fdca6e2e/playlist.m3u8&subcode=en&substitleurl=substitles/series/the-signal/the-signal-s1-ep4-en.srt&title-1=The Signal S1 EP4&img=https://image.tmdb.org/t/p/original/9jt0k9x8vHfMI49G3mmYP9eYn0h.jpg",
});

//Keep Breathing
mapRedirect(["keep-breathing-s1-ep1", "3614968"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lY1mHD7CH0Elty45QMyK3yaf4Xe.jpg",
    title: "Watch Keep Breathing Season 1 Episode 1 - English Subtitle",
    video: "series.html?source=https://ai.bigtimedelivery.net/_v13/86caa1491583318b6f8c34094161e2b0fcfd286e8d37bf4c80aa74d15aadf6f6e67116fe4eae1ac2c1ab6988d6d96e22e512b58c47d4bdb72630ad48bc516059858e7d75b1e3658ecb709b799d50d1f75e3c33cafefdf99bc58f748fb7bc42f1ac5c91643acf61a463bd5675581c5a3e1ec6591ea29a0841c890b48c559260d4e19725ea4259ad4fe76bc8c58d3fcd5b/playlist.m3u8&subcode=en&substitleurl=substitles/series/keep-breathing/keep-breathing-s1-ep1-en.srt&title-1=Keep Breathing S1 EP1&img=https://media.themoviedb.org/t/p/original/q6oyKrOxEAhiKotmYdZVjnwG0K9.jpg",
    video2: "series2.html?source=https://ai.bigtimedelivery.net/_v13/86caa1491583318b6f8c34094161e2b0fcfd286e8d37bf4c80aa74d15aadf6f6e67116fe4eae1ac2c1ab6988d6d96e22e512b58c47d4bdb72630ad48bc516059858e7d75b1e3658ecb709b799d50d1f75e3c33cafefdf99bc58f748fb7bc42f1ac5c91643acf61a463bd5675581c5a3e1ec6591ea29a0841c890b48c559260d4e19725ea4259ad4fe76bc8c58d3fcd5b/playlist.m3u8&subcode=en&substitleurl=substitles/series/keep-breathing/keep-breathing-s1-ep1-en.srt&title-1=Keep Breathing S1 EP1&img=https://media.themoviedb.org/t/p/original/q6oyKrOxEAhiKotmYdZVjnwG0K9.jpg",
});
mapRedirect(["keep-breathing-s1-ep2", "3848053"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lY1mHD7CH0Elty45QMyK3yaf4Xe.jpg",
    title: "Watch Keep Breathing Season 1 Episode 2 - English Subtitle",
    video: "series.html?source=https://ad.bigtimedelivery.net/_v13/801391aab180b350111b2dd07f30da58f9b1b016585b2624a660a2b1650bd48223783abcd64c3e00c14e5b38eac2f79b905c05aaf3ba11b49c630c1ad4a71acf713db3c8d4d4a3bc31c4823a17c7c7762f090315769eb156926c53fc78a9457aa08c81dc7f5d173fdf3c3c91d4af472b36d4d6743899c3057510b7e160019fe6bdd70137fd32f7128fbaea8d81e39a5b/playlist.m3u8&subcode=en&substitleurl=substitles/series/keep-breathing/keep-breathing-s1-ep2-en.srt&title-1=Keep Breathing S1 EP2&img=https://media.themoviedb.org/t/p/original/5Vk5lTFU0GVeOqWd40lDWoaBDjX.jpg",
    video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/801391aab180b350111b2dd07f30da58f9b1b016585b2624a660a2b1650bd48223783abcd64c3e00c14e5b38eac2f79b905c05aaf3ba11b49c630c1ad4a71acf713db3c8d4d4a3bc31c4823a17c7c7762f090315769eb156926c53fc78a9457aa08c81dc7f5d173fdf3c3c91d4af472b36d4d6743899c3057510b7e160019fe6bdd70137fd32f7128fbaea8d81e39a5b/playlist.m3u8&subcode=en&substitleurl=substitles/series/keep-breathing/keep-breathing-s1-ep2-en.srt&title-1=Keep Breathing S1 EP2&img=https://media.themoviedb.org/t/p/original/5Vk5lTFU0GVeOqWd40lDWoaBDjX.jpg",
});
mapRedirect(["keep-breathing-s1-ep3", "3848054"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lY1mHD7CH0Elty45QMyK3yaf4Xe.jpg",
    title: "Watch Keep Breathing Season 1 Episode 3 - English Subtitle",
    video: "series.html?source=https://ab.bigtimedelivery.net/_v13/d002965bfa4f1d3cd75a58a8c9596117bcb51b4d3b31e7fbbb3b9588f649b74288121c6a492f1860ecd18205ad759a8abb264dddad1d3d0f892faec054d6696c75b37e600987d72d1aa2b51eac717b50a9add93c87e351f6cc5e043681728e8e4eac379db9cf6bbb2197cd78b6e0f5ed0ebfc12cb4a31a7333d4c338883afa8d0858ee26ab3d51ff73814ca35dd14a62/playlist.m3u8&subcode=en&substitleurl=substitles/series/keep-breathing/keep-breathing-s1-ep3-en.srt&title-1=Keep Breathing S1 EP3&img=https://media.themoviedb.org/t/p/original/7ZYILDu1tmOWGT4x66jTynAPMAy.jpg",
    video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/d002965bfa4f1d3cd75a58a8c9596117bcb51b4d3b31e7fbbb3b9588f649b74288121c6a492f1860ecd18205ad759a8abb264dddad1d3d0f892faec054d6696c75b37e600987d72d1aa2b51eac717b50a9add93c87e351f6cc5e043681728e8e4eac379db9cf6bbb2197cd78b6e0f5ed0ebfc12cb4a31a7333d4c338883afa8d0858ee26ab3d51ff73814ca35dd14a62/playlist.m3u8&subcode=en&substitleurl=substitles/series/keep-breathing/keep-breathing-s1-ep3-en.srt&title-1=Keep Breathing S1 EP3&img=https://media.themoviedb.org/t/p/original/7ZYILDu1tmOWGT4x66jTynAPMAy.jpg",
});
mapRedirect(["keep-breathing-s1-ep4", "3848055"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lY1mHD7CH0Elty45QMyK3yaf4Xe.jpg",
    title: "Watch Keep Breathing Season 1 Episode 4 - English Subtitle",
    video: "series.html?source=https://ac.bigtimedelivery.net/_v13/b8696067fecc00c573ed6f3af78b1cf2bf8825be8b3d60a7427bf0b850d2fe412a4619fb36e44c6e712316f2448da6596202fa8746f22c3fc45e4720932787a305a02b1c034ea751e465db2129d38004a08419a77de35398026e2e117e0cc009fe38cf36369b799505eea39749151b5f846a060246d032b2c6e8249c63bc2ca44aeee769843a3c2469a7e2afdc04cb65/playlist.m3u8&subcode=en&substitleurl=substitles/series/keep-breathing/keep-breathing-s1-ep4-en.srt&title-1=Keep Breathing S1 EP4&img=https://media.themoviedb.org/t/p/original/607Anj72SIy4r4PVWVAxZ3ABovH.jpg",
    video2: "series2.html?source=https://ac.bigtimedelivery.net/_v13/b8696067fecc00c573ed6f3af78b1cf2bf8825be8b3d60a7427bf0b850d2fe412a4619fb36e44c6e712316f2448da6596202fa8746f22c3fc45e4720932787a305a02b1c034ea751e465db2129d38004a08419a77de35398026e2e117e0cc009fe38cf36369b799505eea39749151b5f846a060246d032b2c6e8249c63bc2ca44aeee769843a3c2469a7e2afdc04cb65/playlist.m3u8&subcode=en&substitleurl=substitles/series/keep-breathing/keep-breathing-s1-ep4-en.srt&title-1=Keep Breathing S1 EP4&img=https://media.themoviedb.org/t/p/original/607Anj72SIy4r4PVWVAxZ3ABovH.jpg",
});
mapRedirect(["keep-breathing-s1-ep5", "3848056"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lY1mHD7CH0Elty45QMyK3yaf4Xe.jpg",
    title: "Watch Keep Breathing Season 1 Episode 5 - English Subtitle",
    video: "series.html?source=https://ac.bigtimedelivery.net/_v13/016d16d0e1cb1514d182d35226dd3357316594f26c041a2a755f0318964bc4ad0cf1e16931da2023e457c0a40d0fdcc059ed6245aa00331ff6ce5beb2268ef2dad91a0c0e95b12b56d27ca1a7e35be5533fba64a17aaf817f57576db10e4ee8a0567e32d802b0e6be4c20d20a0799d947157094933f2c88f610f5acc229d2ffada38ca2ccdf6c52804277cccf17634ef/playlist.m3u8&subcode=en&substitleurl=substitles/series/keep-breathing/keep-breathing-s1-ep5-en.srt&title-1=Keep Breathing S1 EP5&img=https://media.themoviedb.org/t/p/original/FeTaBMo7Ru5FnJ1AWT6vWlADNC.jpg",
    video2: "series2.html?source=https://ac.bigtimedelivery.net/_v13/016d16d0e1cb1514d182d35226dd3357316594f26c041a2a755f0318964bc4ad0cf1e16931da2023e457c0a40d0fdcc059ed6245aa00331ff6ce5beb2268ef2dad91a0c0e95b12b56d27ca1a7e35be5533fba64a17aaf817f57576db10e4ee8a0567e32d802b0e6be4c20d20a0799d947157094933f2c88f610f5acc229d2ffada38ca2ccdf6c52804277cccf17634ef/playlist.m3u8&subcode=en&substitleurl=substitles/series/keep-breathing/keep-breathing-s1-ep5-en.srt&title-1=Keep Breathing S1 EP5&img=https://media.themoviedb.org/t/p/original/FeTaBMo7Ru5FnJ1AWT6vWlADNC.jpg",
});
mapRedirect(["keep-breathing-s1-ep6", "3848057"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/lY1mHD7CH0Elty45QMyK3yaf4Xe.jpg",
    title: "Watch Keep Breathing Season 1 Episode 6 - English Subtitle",
    video: "series.html?source=https://ag.bigtimedelivery.net/_v13/076b0d12aff16886ab011b6608d8186b49abdb520c343c4e3b36a7f00f4fb2b65060ad4970ab082ce9bec3af36bbb4da281366e5f62e90497c50c5956c71075112b4f1a87fe8766a401bc2817b04e3a61f8b68fd45158f9d13fd20e795ee0e4a4fbf64f69471fc8f2b7419e8c8d800cfe1a33258cfb5e5404d94f9d686b1ada966eb8bbea53ae534b27ddd1272afa988/playlist.m3u8&subcode=en&substitleurl=substitles/series/keep-breathing/keep-breathing-s1-ep6-en.srt&title-1=Keep Breathing S1 EP6&img=https://media.themoviedb.org/t/p/original/anYIWF3NTOGihUAKwo6A0HXTFR6.jpg",
    video2: "series2.html?source=https://ag.bigtimedelivery.net/_v13/076b0d12aff16886ab011b6608d8186b49abdb520c343c4e3b36a7f00f4fb2b65060ad4970ab082ce9bec3af36bbb4da281366e5f62e90497c50c5956c71075112b4f1a87fe8766a401bc2817b04e3a61f8b68fd45158f9d13fd20e795ee0e4a4fbf64f69471fc8f2b7419e8c8d800cfe1a33258cfb5e5404d94f9d686b1ada966eb8bbea53ae534b27ddd1272afa988/playlist.m3u8&subcode=en&substitleurl=substitles/series/keep-breathing/keep-breathing-s1-ep6-en.srt&title-1=Keep Breathing S1 EP6&img=https://media.themoviedb.org/t/p/original/anYIWF3NTOGihUAKwo6A0HXTFR6.jpg",
});
mapRedirect(["the-8-show-s1-ep1", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/5BvjF6KH25BKSQcNYDdzVhtnPzJ.jpg",
    title: "Watch The 8 Show Season 1 Episode 1 - HIndi + English",
    video: "https://cdn.asumanaksoy.com/video/5001e11e24d2f4e723a67feb678f4e27",
    video2: "https://cdn.asumanaksoy.com/video/5001e11e24d2f4e723a67feb678f4e27",
});
mapRedirect(["the-8-show-s1-ep2", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/5BvjF6KH25BKSQcNYDdzVhtnPzJ.jpg",
    title: "Watch The 8 Show Season 1 Episode 2 - HIndi + English",
    video: "https://cdn.asumanaksoy.com/video/ef95e8a96e7ae66d9a053c3fb85f7230",
    video2: "https://cdn.asumanaksoy.com/video/ef95e8a96e7ae66d9a053c3fb85f7230",
});
mapRedirect(["the-8-show-s1-ep3", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/5BvjF6KH25BKSQcNYDdzVhtnPzJ.jpg",
    title: "Watch The 8 Show Season 1 Episode 3 - HIndi + English",
    video: "https://cdn.asumanaksoy.com/video/ddcd0c0f094cd80726fd6d6567a1a01b",
    video2: "https://cdn.asumanaksoy.com/video/ddcd0c0f094cd80726fd6d6567a1a01b",
});
mapRedirect(["the-8-show-s1-ep4", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/5BvjF6KH25BKSQcNYDdzVhtnPzJ.jpg",
    title: "Watch The 8 Show Season 1 Episode 4 - HIndi + English",
    video: "https://cdn.asumanaksoy.com/video/0ead717779244d9aab5c1699308850d2",
    video2: "https://cdn.asumanaksoy.com/video/0ead717779244d9aab5c1699308850d2",
});
mapRedirect(["the-8-show-s1-ep5", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/5BvjF6KH25BKSQcNYDdzVhtnPzJ.jpg",
    title: "Watch The 8 Show Season 1 Episode 5 - HIndi + English",
    video: "https://cdn.asumanaksoy.com/video/0226aa5193c66d9906300c6cf2bc45df",
    video2: "https://cdn.asumanaksoy.com/video/0226aa5193c66d9906300c6cf2bc45df",
});
mapRedirect(["the-8-show-s1-ep6", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/5BvjF6KH25BKSQcNYDdzVhtnPzJ.jpg",
    title: "Watch The 8 Show Season 1 Episode 6 - HIndi + English",
    video: "https://cdn.asumanaksoy.com/video/101d3ee2395bb1d1aca582263378d26a",
    video2: "https://cdn.asumanaksoy.com/video/101d3ee2395bb1d1aca582263378d26a",
});
mapRedirect(["the-8-show-s1-ep7", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/5BvjF6KH25BKSQcNYDdzVhtnPzJ.jpg",
    title: "Watch The 8 Show Season 1 Episode 7 - HIndi + English",
    video: "https://cdn.asumanaksoy.com/video/eb72d013ce941d098d78e1ed837a7b92",
    video2: "https://cdn.asumanaksoy.com/video/eb72d013ce941d098d78e1ed837a7b92",
});
mapRedirect(["the-8-show-s1-ep8", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/5BvjF6KH25BKSQcNYDdzVhtnPzJ.jpg",
    title: "Watch The 8 Show Season 1 Episode 8 - HIndi + English",
    video: "https://cdn.asumanaksoy.com/video/c0f3a9cc8c0672341632498cdfb3fff9",
    video2: "https://cdn.asumanaksoy.com/video/c0f3a9cc8c0672341632498cdfb3fff9",
});
mapRedirect(["lupin-hindi-s1-ep1", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/IONmheNL3iMogzOYX0PYlpmkxA.jpg",
    title: "Watch Lupin Season 1 Episode 1 - Hindi Dubbed",
    video: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
    video2: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
});
mapRedirect(["lupin-hindi-s1-ep2", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/IONmheNL3iMogzOYX0PYlpmkxA.jpg",
    title: "Watch Lupin Season 1 Episode 2 - Hindi Dubbed",
    video: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
    video2: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
});
mapRedirect(["lupin-hindi-s1-ep3", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/IONmheNL3iMogzOYX0PYlpmkxA.jpg",
    title: "Watch Lupin Season 1 Episode 3 - Hindi Dubbed",
    video: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
    video2: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
});
mapRedirect(["lupin-hindi-s1-ep4", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/IONmheNL3iMogzOYX0PYlpmkxA.jpg",
    title: "Watch Lupin Season 1 Episode 4 - Hindi Dubbed",
    video: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
    video2: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
});
mapRedirect(["lupin-hindi-s1-ep5", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/IONmheNL3iMogzOYX0PYlpmkxA.jpg",
    title: "Watch Lupin Season 1 Episode 5 - Hindi Dubbed",
    video: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
    video2: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
});
mapRedirect(["lupin-hindi-s1-ep6", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/IONmheNL3iMogzOYX0PYlpmkxA.jpg",
    title: "Watch Lupin Season 1 Episode 6 - Hindi Dubbed",
    video: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
    video2: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
});
mapRedirect(["lupin-hindi-s1-ep7", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/IONmheNL3iMogzOYX0PYlpmkxA.jpg",
    title: "Watch Lupin Season 1 Episode 7 - Hindi Dubbed",
    video: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
    video2: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
});
mapRedirect(["lupin-hindi-s1-ep8", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/IONmheNL3iMogzOYX0PYlpmkxA.jpg",
    title: "Watch Lupin Season 1 Episode 8 - Hindi Dubbed",
    video: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
    video2: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
});
mapRedirect(["lupin-hindi-s1-ep9", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/IONmheNL3iMogzOYX0PYlpmkxA.jpg",
    title: "Watch Lupin Season 1 Episode 9 - Hindi Dubbed",
    video: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
    video2: "http://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
});
mapRedirect(["lupin-hindi-s1-ep10", ""], {
    splashimgurl: "https://image.tmdb.org/t/p/original/IONmheNL3iMogzOYX0PYlpmkxA.jpg",
    title: "Watch Lupin Season 1 Episode 10 - Hindi Dubbed",
    video: "shttp://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
    video2: "shttp://proxy.hdmovie2.baby/?cdURL=aHR0cHM6Ly93YWx0ZXJ3aGl0ZS55ZGMxd2VzLm1lL3YvMDIvMDAwMDYvbndsMjhyeW1ka3ZzX2gvUHJtb3ZpZXMtTHVwaW5fUzFfSGluZGkubXA0P3Q9VTdRZTlXMWhpWDk1enlnUjJEdks1UGg0a2tvcGswU2t3UnpIdUkyZWt0RSZhbXA7cz0xNzIyMjc1MDY2JmFtcDtlPTIxNjAwJmFtcDtmPTMwNTE3JmFtcDtzcD01NDAmYW1wO2k9MC4w",
});

//Breaking Bad
mapRedirect(["breaking-bad-s1-ep1", "62085"], {
    splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
    title: "Watch Breaking Bad Season 1 Episode 1",
    video: "series.html?source=https://ah.bigtimedelivery.net/_v13/511bda70d81b451b7d62a9d27b65f53a13b56dec5cdad7e1366c262b0e04e0209386ed240c607d015f832f623ce2970188befdc749edbcfc644e7cfacb5ea077e8a2f5fae5f7cfb70ad2c65a69ae89f19bf412669e3fadb691478d0fc96d5ac68fc8e8dd64c9518c5303b0621e058b750365eb822f6a870aa26af0000cdd03125381288b5024426ee960b427759b0427/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s1-ep1-en.srt&title-1=Breaking Bad S1 EP1&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    video2: "series2.html?source=https://ah.bigtimedelivery.net/_v13/511bda70d81b451b7d62a9d27b65f53a13b56dec5cdad7e1366c262b0e04e0209386ed240c607d015f832f623ce2970188befdc749edbcfc644e7cfacb5ea077e8a2f5fae5f7cfb70ad2c65a69ae89f19bf412669e3fadb691478d0fc96d5ac68fc8e8dd64c9518c5303b0621e058b750365eb822f6a870aa26af0000cdd03125381288b5024426ee960b427759b0427/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s1-ep1-en.srt&title-1=Breaking Bad S1 EP1&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
}),
    mapRedirect(["breaking-bad-s1-ep2", "62086"], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 1 Episode 2",
        video: "series.html?source=https://af.bigtimedelivery.net/_v13/f407324c16ab9cd38ebb53bb52a85648d32897b782215cd01167ef32f63a29a43e14956978bcfb71af1287af97e4cc73dfcfe59bffe855465c75e5da503a9ad96cdb3be8bbb2abe615c498dccbecbcdd6eb0445928448ad561abace33e163b645ac57548b4d13014827e8f881735a3d4c9aac7df4f40e405c2e0345ace21f5f85e9a41972de86ccdeeded1e51047265b/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s1-ep2-en.srt&title-1=Breaking Bad S1 EP2&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/f407324c16ab9cd38ebb53bb52a85648d32897b782215cd01167ef32f63a29a43e14956978bcfb71af1287af97e4cc73dfcfe59bffe855465c75e5da503a9ad96cdb3be8bbb2abe615c498dccbecbcdd6eb0445928448ad561abace33e163b645ac57548b4d13014827e8f881735a3d4c9aac7df4f40e405c2e0345ace21f5f85e9a41972de86ccdeeded1e51047265b/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s1-ep2-en.srt&title-1=Breaking Bad S1 EP2&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s1-ep3", "62087"], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 1 Episode 3",
        video: "series.html?source=https://aa.bigtimedelivery.net/_v13/0d54d67bf32f85196d0b8a40d01c1fe2c7f46d8c8abeb7cd82db8d38a74fc860a5ff97109ae360e8869d1a9243470145156e00e35b2a6168151f37b23c76137fb9ec4de31e7cc8217983711f08c39b0fb15a5fb725e06a580f6503b3b2ab23014053a05525bc07190d159cc12cafdcfbc2e5dbcce12522373f59b13ab2434624c4eedaa7051b51c24c5306cd9bac2e91/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s1-ep3-en.srt&title-1=Breaking Bad S1 EP3&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/0d54d67bf32f85196d0b8a40d01c1fe2c7f46d8c8abeb7cd82db8d38a74fc860a5ff97109ae360e8869d1a9243470145156e00e35b2a6168151f37b23c76137fb9ec4de31e7cc8217983711f08c39b0fb15a5fb725e06a580f6503b3b2ab23014053a05525bc07190d159cc12cafdcfbc2e5dbcce12522373f59b13ab2434624c4eedaa7051b51c24c5306cd9bac2e91/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s1-ep3-en.srt&title-1=Breaking Bad S1 EP3&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s1-ep4", "62088"], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 1 Episode 4",
        video: "series.html?source=https://ai.bigtimedelivery.net/_v13/f6a85e3438dab799080d2cdd8f5273b5292647474fa16a416ef029a60f73d7f5d99cc83da0c33d49d30cce7e429ac70f5aff6a0ed8aef5e4573002ade28bf93a82924ad493e6ccce078dc59a51976931e1303a10658ca60e980263b2cca56e4d97c2b17aa4942260a9e0fffc8722578d749f01ae6132fac868a5aef80bbfc82d40c9547b10688ebe7cb50ea0da2aa9ba/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s1-ep4-en.srt&title-1=Breaking Bad S1 EP4&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ai.bigtimedelivery.net/_v13/f6a85e3438dab799080d2cdd8f5273b5292647474fa16a416ef029a60f73d7f5d99cc83da0c33d49d30cce7e429ac70f5aff6a0ed8aef5e4573002ade28bf93a82924ad493e6ccce078dc59a51976931e1303a10658ca60e980263b2cca56e4d97c2b17aa4942260a9e0fffc8722578d749f01ae6132fac868a5aef80bbfc82d40c9547b10688ebe7cb50ea0da2aa9ba/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s1-ep4-en.srt&title-1=Breaking Bad S1 EP4&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s1-ep5", "62089"], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 1 Episode 5",
        video: "series.html?source=https://af.bigtimedelivery.net/_v13/fc5e2a37219a9036bbee3458f082eb31d9a45a2d49dcdb3a62057478628fa772dde48276c168f8057af865663896daad17032a723024c9c217ef2d55ae425c32fe60193c93ca7d659bf0e26092301f3e29984f464b36aa53348d037ebbaeed234033c6ee01af13820a502e09879cef63761c7e54d0be6047c140e71fff41d176d1d56f982258f289612276c70f40bbe4/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s1-ep5-en.srt&title-1=Breaking Bad S1 EP5&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/fc5e2a37219a9036bbee3458f082eb31d9a45a2d49dcdb3a62057478628fa772dde48276c168f8057af865663896daad17032a723024c9c217ef2d55ae425c32fe60193c93ca7d659bf0e26092301f3e29984f464b36aa53348d037ebbaeed234033c6ee01af13820a502e09879cef63761c7e54d0be6047c140e71fff41d176d1d56f982258f289612276c70f40bbe4/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s1-ep5-en.srt&title-1=Breaking Bad S1 EP5&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s1-ep6", "62090"], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 1 Episode 6",
        video: "series.html?source=https://ad.bigtimedelivery.net/_v13/c52b2e6ee4f277c75699edc8ddabfd4665e56a6c479b11663909354f3cac0080064090cd4527227695cde9ea773438e7d5c8a403746e9072a9a131b05c084747838b334dc0e39ff9f6c0f1c1266a6b06f072e34f66c55c5f0c42f2f0cd6f3ee9d2b5fb1d9a3e5535912a8ba6524e04900448fe95d22d408782c5b910075199b8e66b093ce013105898467c732c87e044/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s1-ep6-en.srt&title-1=Breaking Bad S1 EP6&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/c52b2e6ee4f277c75699edc8ddabfd4665e56a6c479b11663909354f3cac0080064090cd4527227695cde9ea773438e7d5c8a403746e9072a9a131b05c084747838b334dc0e39ff9f6c0f1c1266a6b06f072e34f66c55c5f0c42f2f0cd6f3ee9d2b5fb1d9a3e5535912a8ba6524e04900448fe95d22d408782c5b910075199b8e66b093ce013105898467c732c87e044/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s1-ep6-en.srt&title-1=Breaking Bad S1 EP6&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s1-ep7", "62091"], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 1 Episode 7",
        video: "series.html?source=https://ai.bigtimedelivery.net/_v13/1c4866fe9f380c01e402d911ff8143b7d5b0a76b98f88a54f9dc1f02ec2ed3beac8fe6dc87db04eed50aeba896082f5845712e450dcf0cc1156f9b5d333837b42f22f61967a1f36e9d41ee4ad64bc27eb6cd39d4dfbbfa5b05e254dd53bcdabad0217f782f3a70ae1a385ccba5b1eea97b0fa2f7e2a0b4feafffda30340d8013cf91858b9172179eb3d5a234faf74752/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s1-ep7-en.srt&title-1=Breaking Bad S1 EP7&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ai.bigtimedelivery.net/_v13/1c4866fe9f380c01e402d911ff8143b7d5b0a76b98f88a54f9dc1f02ec2ed3beac8fe6dc87db04eed50aeba896082f5845712e450dcf0cc1156f9b5d333837b42f22f61967a1f36e9d41ee4ad64bc27eb6cd39d4dfbbfa5b05e254dd53bcdabad0217f782f3a70ae1a385ccba5b1eea97b0fa2f7e2a0b4feafffda30340d8013cf91858b9172179eb3d5a234faf74752/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s1-ep7-en.srt&title-1=Breaking Bad S1 EP7&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),


    //Breaking Bad Season 2
    mapRedirect(["breaking-bad-s2-ep1", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 2 Episode 1",
        video: "series.html?source=https://ah.bigtimedelivery.net/_v13/509079907a72a5cd67de577919d9456963d60d8a612b1734be585866ab7fd43ec22273ac04a22d52ef1de7665210a7033793835e56469df619e379864d6e9ea39002405018e31f48b543794bef0f44cf9ee63940d404c4ccca727467375d0eddc39a4dad184668d4a78c847692ce5eabad869b3efe28b1911be905b1c63ac123393a157e7aa7f4ba2d6b87b886480b46/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep1-en.srt&title-1=Breaking Bad S2 EP1&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ah.bigtimedelivery.net/_v13/509079907a72a5cd67de577919d9456963d60d8a612b1734be585866ab7fd43ec22273ac04a22d52ef1de7665210a7033793835e56469df619e379864d6e9ea39002405018e31f48b543794bef0f44cf9ee63940d404c4ccca727467375d0eddc39a4dad184668d4a78c847692ce5eabad869b3efe28b1911be905b1c63ac123393a157e7aa7f4ba2d6b87b886480b46/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep1-en.srt&title-1=Breaking Bad S2 EP1&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s2-ep2", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 2 Episode 2",
        video: "series.html?source=https://ad.bigtimedelivery.net/_v13/12af66fa772a5e345467ea26d5109cdecf03acba8c5aa5a050678fdedc703e4aff02de671257c499f77a926513a4865f06265120ed43fc4c3e3845418602de723db74397409c64bb87df87cb758e1dadcf9d2c82f4026735b29a82fcfe15a2bdd6da2d8f144720dc6c9aa12675af97d90fb0adb14483a8f809bcd0d917d58f7df181699ed7c3f6481f725842a7fc9d18/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep2-en.srt&title-1=Breaking Bad S2 EP2&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/12af66fa772a5e345467ea26d5109cdecf03acba8c5aa5a050678fdedc703e4aff02de671257c499f77a926513a4865f06265120ed43fc4c3e3845418602de723db74397409c64bb87df87cb758e1dadcf9d2c82f4026735b29a82fcfe15a2bdd6da2d8f144720dc6c9aa12675af97d90fb0adb14483a8f809bcd0d917d58f7df181699ed7c3f6481f725842a7fc9d18/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep2-en.srt&title-1=Breaking Bad S2 EP2&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s2-ep3", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 2 Episode 3",
        video: "series.html?source=https://aa.bigtimedelivery.net/_v13/7b9879657b713d4a2616d351de7b1e3bffb2ec317aa7a58a636ad260723dced2818cc9055ae4f9f9862ce8e323ad28c862a6ef03777161f94817db2409e8ce1cf7507a3f0d395019e229a47b0cccc0f46f9bb42c8c94f355d47f0239e2ed80b0ca3e9ac884211e5b44dd4a947b51688a92380b18c4a6e7160cce0f92f536b1fc154b488fa11cec122088d90729618973/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep3-en.srt&title-1=Breaking Bad S2 EP3&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/7b9879657b713d4a2616d351de7b1e3bffb2ec317aa7a58a636ad260723dced2818cc9055ae4f9f9862ce8e323ad28c862a6ef03777161f94817db2409e8ce1cf7507a3f0d395019e229a47b0cccc0f46f9bb42c8c94f355d47f0239e2ed80b0ca3e9ac884211e5b44dd4a947b51688a92380b18c4a6e7160cce0f92f536b1fc154b488fa11cec122088d90729618973/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep3-en.srt&title-1=Breaking Bad S2 EP3&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s2-ep4", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 2 Episode 4",
        video: "series.html?source=https://ab.bigtimedelivery.net/_v13/9d48e9eaa9afa2de8919d22e09040e6c82b10b0f750642a059c9dc7eaf5f612e8385dedd3c04d9db91f810c4067161b06bf49e335a00c8c1c4e092a46adf6ebdbe1f0577aace97918818bec1708a916f342e3eaa6e051e218845e776a6b4c9632cc169d8a238258cec0270d8e34567c52ea02e38c9523befe60b52907544bb49d4ea59ef414ff4b52a698d4ddaa41904/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep4-en.srt&title-1=Breaking Bad S2 EP4&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/9d48e9eaa9afa2de8919d22e09040e6c82b10b0f750642a059c9dc7eaf5f612e8385dedd3c04d9db91f810c4067161b06bf49e335a00c8c1c4e092a46adf6ebdbe1f0577aace97918818bec1708a916f342e3eaa6e051e218845e776a6b4c9632cc169d8a238258cec0270d8e34567c52ea02e38c9523befe60b52907544bb49d4ea59ef414ff4b52a698d4ddaa41904/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep4-en.srt&title-1=Breaking Bad S2 EP4&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s2-ep5", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 2 Episode 5",
        video: "series.html?source=https://ad.bigtimedelivery.net/_v13/2d78a2c225b90a96dca0f9f148b89f281b50d386a88045356aff075ffa16794a4af7f73508a502db44e5218a44e66159e0eab6bec85d98a7b2f1e87e757c833b6e0bc4aedfb9bbce04bef0d8e1d686eaa592a24f87610e5a6db3b01cb3397ada3f79c5bbf3edfcdbd9be82144187f928401baf179afbc02670934f548165ccdb964001a72b0069ca5564ff58ed440a77/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep5-en.srt&title-1=Breaking Bad S2 EP5&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/2d78a2c225b90a96dca0f9f148b89f281b50d386a88045356aff075ffa16794a4af7f73508a502db44e5218a44e66159e0eab6bec85d98a7b2f1e87e757c833b6e0bc4aedfb9bbce04bef0d8e1d686eaa592a24f87610e5a6db3b01cb3397ada3f79c5bbf3edfcdbd9be82144187f928401baf179afbc02670934f548165ccdb964001a72b0069ca5564ff58ed440a77/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep5-en.srt&title-1=Breaking Bad S2 EP5&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s2-ep6", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 2 Episode 6",
        video: "series.html?source=https://aa.bigtimedelivery.net/_v13/33334bcc868a5015648f4103ed97dab75a5f1ccef1fd3d70ed28d08547db85483e9ac3290f97828ef8c4838c2dc9b3f2624504f64f05b89e45ca94842d330576bfb3c460bf6d34164137b6a433e0af4cc65da5bf2006887cea767bd8ec9c041c1fe6f12fb82947a0a876f3490ff152dbbbb857df8a3349d4b0febcda9e8ade7487db34c20652a622128f4d0885017174/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep6-en.srt&title-1=Breaking Bad S2 EP6&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/33334bcc868a5015648f4103ed97dab75a5f1ccef1fd3d70ed28d08547db85483e9ac3290f97828ef8c4838c2dc9b3f2624504f64f05b89e45ca94842d330576bfb3c460bf6d34164137b6a433e0af4cc65da5bf2006887cea767bd8ec9c041c1fe6f12fb82947a0a876f3490ff152dbbbb857df8a3349d4b0febcda9e8ade7487db34c20652a622128f4d0885017174/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep6-en.srt&title-1=Breaking Bad S2 EP6&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s2-ep7", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 2 Episode 7",
        video: "series.html?source=https://ah.bigtimedelivery.net/_v13/fba0cd2d05fb9ba4b36c58c0d9f8e99395ad68df47baef3e8f2b8191b24df49b6b8cd26d4486c89ba3cc536799eb76600ee23b76ff6d12b11b20c9abfbbaa7c0fc555ef6b5a6eb203dacd9f66391a208b4fd4594c813988e66a715eac94ae7ea793cdedeb15dd4f3fcf44546588281b7852133b2736f9ac7bacc55d519c5ffacc343c2feaee56a359075d1d56c2a2ebe/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep7-en.srt&title-1=Breaking Bad S2 EP7&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ah.bigtimedelivery.net/_v13/fba0cd2d05fb9ba4b36c58c0d9f8e99395ad68df47baef3e8f2b8191b24df49b6b8cd26d4486c89ba3cc536799eb76600ee23b76ff6d12b11b20c9abfbbaa7c0fc555ef6b5a6eb203dacd9f66391a208b4fd4594c813988e66a715eac94ae7ea793cdedeb15dd4f3fcf44546588281b7852133b2736f9ac7bacc55d519c5ffacc343c2feaee56a359075d1d56c2a2ebe/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep7-en.srt&title-1=Breaking Bad S2 EP7&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s2-ep8", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 2 Episode 8",
        video: "series.html?source=https://aj.bigtimedelivery.net/_v13/99cebb72d02697abd69ef3f7af23ad06844103e43701873ffc602a7686bf55db24528b702949df542def75bafb3eec20f049ecd0b19ac4e651748ecce1075f86f214005cfe2706359996f1de32366c1b4663ea0b3468d154befc95fd52bcfee41700b5f683d99a044c4d81aca592d6f443fee4d8437284fee6907f4fa9cb0069b392818c0a169e33d8081933df6c126e/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep8-en.srt&title-1=Breaking Bad S2 EP8&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/99cebb72d02697abd69ef3f7af23ad06844103e43701873ffc602a7686bf55db24528b702949df542def75bafb3eec20f049ecd0b19ac4e651748ecce1075f86f214005cfe2706359996f1de32366c1b4663ea0b3468d154befc95fd52bcfee41700b5f683d99a044c4d81aca592d6f443fee4d8437284fee6907f4fa9cb0069b392818c0a169e33d8081933df6c126e/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep8-en.srt&title-1=Breaking Bad S2 EP8&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s2-ep9", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 2 Episode 9",
        video: "series.html?source=https://ad.bigtimedelivery.net/_v13/943ba6b47792f90c4850cefc028bf524e3ff41fb7ef6f653764b1996fbc04a657279954f5e6b5fd47e52f54854da1494cd11656453fa7f8192b57cf2f95e9da3e4a258c47a239f5bb30d2abf562dd1809fa5fabeb2e9923c71dd7cd1f02fe69c76210603317bf9de48d841f8023090463c70886b9bcefe709c9b3cdcdfcd24067888efe6423842b8b40673ac854e0a65/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep9-en.srt&title-1=Breaking Bad S2 EP9&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/943ba6b47792f90c4850cefc028bf524e3ff41fb7ef6f653764b1996fbc04a657279954f5e6b5fd47e52f54854da1494cd11656453fa7f8192b57cf2f95e9da3e4a258c47a239f5bb30d2abf562dd1809fa5fabeb2e9923c71dd7cd1f02fe69c76210603317bf9de48d841f8023090463c70886b9bcefe709c9b3cdcdfcd24067888efe6423842b8b40673ac854e0a65/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep9-en.srt&title-1=Breaking Bad S2 EP9&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s2-ep10", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 2 Episode 10",
        video: "series.html?source=https://af.bigtimedelivery.net/_v13/b2d22ade370158cf93f136a6c293c960cab5a89d842016b38de160d8956c298a56dc1c0af51ca31332dc169ee1d80bff68eb0ee82409daf6c15db96c2836ed5f90b8d7102073ef3c996f0083877edf13a2e2da2d0918215299fd50bcaf37fa2ff8dcb939a876df3ccbb187d20871653980f9e6d7e10421f76bd10ab9251cf47449b8fa769c73700357fbcdbab9428700/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep10-en.srt&title-1=Breaking Bad S2 EP10&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/b2d22ade370158cf93f136a6c293c960cab5a89d842016b38de160d8956c298a56dc1c0af51ca31332dc169ee1d80bff68eb0ee82409daf6c15db96c2836ed5f90b8d7102073ef3c996f0083877edf13a2e2da2d0918215299fd50bcaf37fa2ff8dcb939a876df3ccbb187d20871653980f9e6d7e10421f76bd10ab9251cf47449b8fa769c73700357fbcdbab9428700/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep10-en.srt&title-1=Breaking Bad S2 EP10&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s2-ep11", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 2 Episode 11",
        video: "series.html?source=https://ac.bigtimedelivery.net/_v13/a699fb0b0d19dcd6b9bfa08e126f21d53c2b5fbabb12b3975950369d9063ae101183e532f89d6abaf0659c5c7940275811991413727470513da55d5292214dd4e7f3c904f796cba966fbd99f782a0dc2a6617e67efb74fec22d9a9384721caabf875b6eda8bae596ec841c47708b7d899a8dea6a5ad3affcddec44a32bdcba593249e123ca08b55eb4639d7c5ed5e2f0/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep11-en.srt&title-1=Breaking Bad S2 EP11&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ac.bigtimedelivery.net/_v13/a699fb0b0d19dcd6b9bfa08e126f21d53c2b5fbabb12b3975950369d9063ae101183e532f89d6abaf0659c5c7940275811991413727470513da55d5292214dd4e7f3c904f796cba966fbd99f782a0dc2a6617e67efb74fec22d9a9384721caabf875b6eda8bae596ec841c47708b7d899a8dea6a5ad3affcddec44a32bdcba593249e123ca08b55eb4639d7c5ed5e2f0/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep11-en.srt&title-1=Breaking Bad S2 EP11&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s2-ep12", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 2 Episode 12",
        video: "series.html?source=https://aj.bigtimedelivery.net/_v13/543ba6f0781336fe164b6b8452271a4d2495d451ca33734295d66cda62c34eb583a99e4b7313d877d50d5b5812ea75a0b0dc6dfa59ceb3732193073b2315258afc1fee603026e91d5b91ff64168d253f1a6d57f7fffa3faa1f8eab62cff3161e422734ad41e4e96ab24c901b01dbe19f93c4b9a8c6154486afa84a8bdcc4d454a89b1a517960b2eaf096be88747216e7/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep12-en.srt&title-1=Breaking Bad S2 EP12&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/543ba6f0781336fe164b6b8452271a4d2495d451ca33734295d66cda62c34eb583a99e4b7313d877d50d5b5812ea75a0b0dc6dfa59ceb3732193073b2315258afc1fee603026e91d5b91ff64168d253f1a6d57f7fffa3faa1f8eab62cff3161e422734ad41e4e96ab24c901b01dbe19f93c4b9a8c6154486afa84a8bdcc4d454a89b1a517960b2eaf096be88747216e7/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep12-en.srt&title-1=Breaking Bad S2 EP12&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s2-ep13", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 2 Episode 13",
        video: "series.html?source=https://ac.bigtimedelivery.net/_v13/e4ce4a2d2b416cc9f99fa617e5f9ee606d0fc5758f775665718641eb04bc38cbc661f9cbff9bb62dc7437491594dfc8b2a458d34d2da3626e818e7f4b57817226c6be7b6cb163c226d8168ea2fe95b78ee6d1ad08bc34ca64b609281a89565111a1af93b1af11e11d770835031a2748f8c5cfc77ce59d9db4c267b982423343e4110bdbc050aeddef495a3179c9770f8/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep13-en.srt&title-1=Breaking Bad S2 EP13&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ac.bigtimedelivery.net/_v13/e4ce4a2d2b416cc9f99fa617e5f9ee606d0fc5758f775665718641eb04bc38cbc661f9cbff9bb62dc7437491594dfc8b2a458d34d2da3626e818e7f4b57817226c6be7b6cb163c226d8168ea2fe95b78ee6d1ad08bc34ca64b609281a89565111a1af93b1af11e11d770835031a2748f8c5cfc77ce59d9db4c267b982423343e4110bdbc050aeddef495a3179c9770f8/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s2-ep13-en.srt&title-1=Breaking Bad S2 EP13&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    // Breaking Bad Season 3
    mapRedirect(["breaking-bad-s3-ep1", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 3 Episode 1",
        video: "series.html?source=https://aa.bigtimedelivery.net/_v13/9e42c5b129b0d598715ea427c9413cd6c271e5b199e7b086a5bf7ebaf3842d5004e34a592537f1da78a8ec3734e7306aecb22d6cbee492bd6e71ecac569b8ec86e816c4218d48b87fcafe9a5546ef8352dfcfe1433c82d92f770d27abcb008bdabc99cf06f89dc82b33d2cfa58305484bb2620f599a38d76635df6a66a87f366414153c163e613f359f5c2a099d45ece/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep1-en.srt&title-1=Breaking Bad S3 EP1&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/9e42c5b129b0d598715ea427c9413cd6c271e5b199e7b086a5bf7ebaf3842d5004e34a592537f1da78a8ec3734e7306aecb22d6cbee492bd6e71ecac569b8ec86e816c4218d48b87fcafe9a5546ef8352dfcfe1433c82d92f770d27abcb008bdabc99cf06f89dc82b33d2cfa58305484bb2620f599a38d76635df6a66a87f366414153c163e613f359f5c2a099d45ece/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep1-en.srt&title-1=Breaking Bad S3 EP1&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s3-ep2", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 3 Episode 2",
        video: "series.html?source=https://aa.bigtimedelivery.net/_v13/1784885a3f252a021f395d684211677fac6ad4aa627a5280c4411750e20daf3e34c8d41533027b51f837ac1b419f74994642e6cf2d1dc3ae93b0dda88ae49deb06fdb2979156e1ba4e7f6d32d395f1d44b9417c1e9d286a437a332eaad1157238a21b6eca88ce9b25aaeb97a6eca487b718236701485c5c9420b74bda56493e30705d3f1fa492affc30b802214180f2f/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep2-en.srt&title-1=Breaking Bad S3 EP2&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/1784885a3f252a021f395d684211677fac6ad4aa627a5280c4411750e20daf3e34c8d41533027b51f837ac1b419f74994642e6cf2d1dc3ae93b0dda88ae49deb06fdb2979156e1ba4e7f6d32d395f1d44b9417c1e9d286a437a332eaad1157238a21b6eca88ce9b25aaeb97a6eca487b718236701485c5c9420b74bda56493e30705d3f1fa492affc30b802214180f2f/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep2-en.srt&title-1=Breaking Bad S3 EP2&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s3-ep3", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 3 Episode 3",
        video: "series.html?source=https://af.bigtimedelivery.net/_v13/7b27759ed5138c34fa80a7a9108601859b45f7d0611950f9db8e6416132ce83f1ad09eeb5e05cb5996834c8c99bcd446fa766061621271a15db4663577ffaede5fa03832c1af659e91c6288f1a8670aa73fdee30c2207b5a999736eca44a224a525d8791390c079c1aa2ae3af50d0a67e828e2e45e1cee8da83f3d6e7e5d6ab50b0bc53a76edc17294284e019e918dcb/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep3-en.srt&title-1=Breaking Bad S3 EP3&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/7b27759ed5138c34fa80a7a9108601859b45f7d0611950f9db8e6416132ce83f1ad09eeb5e05cb5996834c8c99bcd446fa766061621271a15db4663577ffaede5fa03832c1af659e91c6288f1a8670aa73fdee30c2207b5a999736eca44a224a525d8791390c079c1aa2ae3af50d0a67e828e2e45e1cee8da83f3d6e7e5d6ab50b0bc53a76edc17294284e019e918dcb/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep3-en.srt&title-1=Breaking Bad S3 EP3&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s3-ep4", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 3 Episode 4",
        video: "series.html?source=https://aj.bigtimedelivery.net/_v13/1a9aebf0aeb1c304da4ca94eafbb3fe61e652eb322e649c9e3e7d9955656842982a257ed60cd6609dff8ff563cb8e853b1b532a834212eba864cab05311935599b3e09a2a7dc3d12b563ca7fa0bd3420dbe15bc50f853cd1bfee81e858b22849429d72f62718ac7535d7522ca0129e73011621392903d8dc2eef23a35cf2a87ccf931bc2885f36dd8ff1e69e2075ffc6/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep4-en.srt&title-1=Breaking Bad S3 EP4&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/1a9aebf0aeb1c304da4ca94eafbb3fe61e652eb322e649c9e3e7d9955656842982a257ed60cd6609dff8ff563cb8e853b1b532a834212eba864cab05311935599b3e09a2a7dc3d12b563ca7fa0bd3420dbe15bc50f853cd1bfee81e858b22849429d72f62718ac7535d7522ca0129e73011621392903d8dc2eef23a35cf2a87ccf931bc2885f36dd8ff1e69e2075ffc6/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep4-en.srt&title-1=Breaking Bad S3 EP4&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s3-ep5", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 3 Episode 5",
        video: "series.html?source=https://ag.bigtimedelivery.net/_v13/9135951a3268f9939ab42c83b68d25ba2be81c903bcdcb8dacd65717ee543c00aabfc02f11076b181abab68c99b393bca7a12645fa4ef228d88ad00a06dd531de569691ced0e72de5840fc7421d39dc0fc30c0b0f0fe07cf21b7c1625a6d30d6be1a1d1f4485b44384636d6d16864862e3053b27bf04a50ac05a702f1c14ad17e4aecf972024a0cd9bfced16d500db88/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep5-en.srt&title-1=Breaking Bad S3 EP5&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ag.bigtimedelivery.net/_v13/9135951a3268f9939ab42c83b68d25ba2be81c903bcdcb8dacd65717ee543c00aabfc02f11076b181abab68c99b393bca7a12645fa4ef228d88ad00a06dd531de569691ced0e72de5840fc7421d39dc0fc30c0b0f0fe07cf21b7c1625a6d30d6be1a1d1f4485b44384636d6d16864862e3053b27bf04a50ac05a702f1c14ad17e4aecf972024a0cd9bfced16d500db88/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep5-en.srt&title-1=Breaking Bad S3 EP5&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s3-ep6", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 3 Episode 6",
        video: "series.html?source=https://af.bigtimedelivery.net/_v13/0851919728f75abebf6235bf4950412bcf1d9593f8ffb58195d799b72be7e0fee76b30a0b70fb210bcb84850184e388ae57efd046989426259367a5ddfe8ba0b6a69e3308544bdb789ad31964f46435c2f0ae3c49d84af93841dd13da5690c9dba5e5f5dc2d5f9c45b35204a0117865b0bcadb4675622a1ac9e29da460e2bae3f1d61215a4ebe60bc2f6fd612eb7ef81/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep6-en.srt&title-1=Breaking Bad S3 EP6&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/0851919728f75abebf6235bf4950412bcf1d9593f8ffb58195d799b72be7e0fee76b30a0b70fb210bcb84850184e388ae57efd046989426259367a5ddfe8ba0b6a69e3308544bdb789ad31964f46435c2f0ae3c49d84af93841dd13da5690c9dba5e5f5dc2d5f9c45b35204a0117865b0bcadb4675622a1ac9e29da460e2bae3f1d61215a4ebe60bc2f6fd612eb7ef81/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep6-en.srt&title-1=Breaking Bad S3 EP6&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s3-ep7", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 3 Episode 7",
        video: "series.html?source=https://aj.bigtimedelivery.net/_v13/b6eea670400f204f8fd142d9d913b9e475d1bd59c347f2a7c770425b80d8513c74f2c27af717f463adce0286dbbc0ed8c5e894aedf3c13be54b9284eee0140595f133f9e750945593291d64d283567159d83bffcb662f548d48c6b5fdce843665864b2664d2e8a2998988716fdcc2bf03d2d067ca845dc4d2c4ee7e3820f3e225b649cc639de3ce09977652d2cc8ba6d/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep7-en.srt&title-1=Breaking Bad S3 EP7&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/b6eea670400f204f8fd142d9d913b9e475d1bd59c347f2a7c770425b80d8513c74f2c27af717f463adce0286dbbc0ed8c5e894aedf3c13be54b9284eee0140595f133f9e750945593291d64d283567159d83bffcb662f548d48c6b5fdce843665864b2664d2e8a2998988716fdcc2bf03d2d067ca845dc4d2c4ee7e3820f3e225b649cc639de3ce09977652d2cc8ba6d/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep7-en.srt&title-1=Breaking Bad S3 EP7&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s3-ep8", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 3 Episode 8",
        video: "series.html?source=https://aa.bigtimedelivery.net/_v13/aeb0a22d35b4484f3fb1ef245df1a2c94ec51d2d752b4aa8063c7674dc01dd3630136295ffc3f9d299000da20c615040079e817c2dada15293f9a461f8fb031dc817bbbd9979ded89957d6f3e099353bdc30ab737254b7064efbfe555f23a99e7733cf345a0dea817659fe51eea25f96125508e185c16173288f572272f7bfbff2486e12d91214d148688e10127c6012/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep8-en.srt&title-1=Breaking Bad S3 EP8&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/aeb0a22d35b4484f3fb1ef245df1a2c94ec51d2d752b4aa8063c7674dc01dd3630136295ffc3f9d299000da20c615040079e817c2dada15293f9a461f8fb031dc817bbbd9979ded89957d6f3e099353bdc30ab737254b7064efbfe555f23a99e7733cf345a0dea817659fe51eea25f96125508e185c16173288f572272f7bfbff2486e12d91214d148688e10127c6012/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep8-en.srt&title-1=Breaking Bad S3 EP8&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s3-ep9", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 3 Episode 9",
        video: "series.html?source=https://aj.bigtimedelivery.net/_v13/bec598dedf0d205bae0eadb3c05faca4d23c45115b2189b9b96c9b4dd5b58d6151843a7da14f3a849c4e63d4ba8a6d788b66269fa3c8cfe75c838eecfc8b34771824d7f80e48eed98183fd4b72fb6c33c50f976625e569c3361bdd1f58c7fd59f29efbebfd6f609232e997755e3c88be8eaf9e8ce1dd46e7dc0a20b8dbe423f3cfa5c3a3aca543e49b87ffd638538bfc/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep9-en.srt&title-1=Breaking Bad S3 EP9&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/bec598dedf0d205bae0eadb3c05faca4d23c45115b2189b9b96c9b4dd5b58d6151843a7da14f3a849c4e63d4ba8a6d788b66269fa3c8cfe75c838eecfc8b34771824d7f80e48eed98183fd4b72fb6c33c50f976625e569c3361bdd1f58c7fd59f29efbebfd6f609232e997755e3c88be8eaf9e8ce1dd46e7dc0a20b8dbe423f3cfa5c3a3aca543e49b87ffd638538bfc/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep9-en.srt&title-1=Breaking Bad S3 EP9&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s3-ep10", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 3 Episode 10",
        video: "series.html?source=https://aj.bigtimedelivery.net/_v13/cabb969ab01449137e2b68fce87848f23ac4fdf81384f6ae686101dc8cf179d75b605691f397a5ae5dca810efbdc4c956d118b569e99bfe96cad2119a25e18c56bf4dfb9f2b01eba19746031f8134e4c83b7f21ab4c5088016074ea16a5beb8fc5b096c328b325c740a72124048ea9bd100589273b86b95287822349073f6ed944a7cebc0ef1a3d5da7e83a9689afc4d/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep10-en.srt&title-1=Breaking Bad S3 EP10&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/cabb969ab01449137e2b68fce87848f23ac4fdf81384f6ae686101dc8cf179d75b605691f397a5ae5dca810efbdc4c956d118b569e99bfe96cad2119a25e18c56bf4dfb9f2b01eba19746031f8134e4c83b7f21ab4c5088016074ea16a5beb8fc5b096c328b325c740a72124048ea9bd100589273b86b95287822349073f6ed944a7cebc0ef1a3d5da7e83a9689afc4d/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep10-en.srt&title-1=Breaking Bad S3 EP10&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s3-ep11", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 3 Episode 11",
        video: "series.html?source=https://ad.bigtimedelivery.net/_v13/31f4c6d49f89a5736001b1e7566ace6617b2fb5e80cd7e579a3aee382c5b4e654fafaae3e7af4a72161250420b9276fde43487e50d16dc9455fb970f3495f45ae54e155cbbe80ec92ac5708e70071febd3308c08c043dfe29f58ad9dfd34ca1f36f83d6ec785d16abf1cbf7915365202891c535d499fb034d97ddee0df42a8d5ec9ccee0e5b8532374e37d8c418b241f/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep11-en.srt&title-1=Breaking Bad S3 EP11&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/31f4c6d49f89a5736001b1e7566ace6617b2fb5e80cd7e579a3aee382c5b4e654fafaae3e7af4a72161250420b9276fde43487e50d16dc9455fb970f3495f45ae54e155cbbe80ec92ac5708e70071febd3308c08c043dfe29f58ad9dfd34ca1f36f83d6ec785d16abf1cbf7915365202891c535d499fb034d97ddee0df42a8d5ec9ccee0e5b8532374e37d8c418b241f/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep11-en.srt&title-1=Breaking Bad S3 EP11&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s3-ep12", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 3 Episode 12",
        video: "series.html?source=https://ae.bigtimedelivery.net/_v13/63eab18a85ec44ad4c31f64ecf1433c7e6c2d881aa1430e4c1d8abaf49724b12b86a7d75dbe466a64736830b65acd598bb2618361ae05f210310ad9d35a995e00591d681d99d5484856baf0a6264383581e19a96a1759ca8f778068eead38a12f624362b7d7925fb2b8d18e83dc007029a59f0a7c3d7852e8f462b71d54aef3c2e63028ae5f3af9c317638f62df720cc/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep12-en.srt&title-1=Breaking Bad S3 EP12&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ae.bigtimedelivery.net/_v13/63eab18a85ec44ad4c31f64ecf1433c7e6c2d881aa1430e4c1d8abaf49724b12b86a7d75dbe466a64736830b65acd598bb2618361ae05f210310ad9d35a995e00591d681d99d5484856baf0a6264383581e19a96a1759ca8f778068eead38a12f624362b7d7925fb2b8d18e83dc007029a59f0a7c3d7852e8f462b71d54aef3c2e63028ae5f3af9c317638f62df720cc/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep12-en.srt&title-1=Breaking Bad S3 EP12&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s3-ep13", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 3 Episode 13",
        video: "series.html?source=https://ae.bigtimedelivery.net/_v13/0e0fc028c66fe855c9d2480164158f7011ad1c16c217d4ca5197da80f2dfdbf88fb6e3593f6c608ede9625b0cd99cc2bc58cbb387534537c252720d3252cdb76d8757f4eb16ad7386b9fa7e4c5f95b528b81dcd65809b445c97545f94c571c5fff3f08674c7f97e3196a370710cec85b66135bc309cfdebaf84c8008d82051f02b27bf97d4a94e6bb2ec29304911bd53/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep13-en.srt&title-1=Breaking Bad S3 EP13&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ae.bigtimedelivery.net/_v13/0e0fc028c66fe855c9d2480164158f7011ad1c16c217d4ca5197da80f2dfdbf88fb6e3593f6c608ede9625b0cd99cc2bc58cbb387534537c252720d3252cdb76d8757f4eb16ad7386b9fa7e4c5f95b528b81dcd65809b445c97545f94c571c5fff3f08674c7f97e3196a370710cec85b66135bc309cfdebaf84c8008d82051f02b27bf97d4a94e6bb2ec29304911bd53/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s3-ep13-en.srt&title-1=Breaking Bad S3 EP13&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    // Breaking Bad Season 4
    mapRedirect(["breaking-bad-s4-ep1", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 4 Episode 1",
        video: "series.html?source=https://aa.bigtimedelivery.net/_v13/dab23c1729221451a7b15f52530145c32b8057b140617dffa96f69926ba57105cd4bf268ec164f473d7bf72912422d91cd2074af04fb77be564c9565ed27a012d443dbf69bad43248960f7f456a1d28412db7c1fdc478aeb69e544f5b7d8a97c88a20d43bca107f054c5c64c4ea8b12bebb611b20bacbfccc1bafdeba19ce5913b4832185fa4a2e5c42310f2b96a175b/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep1-en.srt&title-1=Breaking Bad S4 EP1&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/dab23c1729221451a7b15f52530145c32b8057b140617dffa96f69926ba57105cd4bf268ec164f473d7bf72912422d91cd2074af04fb77be564c9565ed27a012d443dbf69bad43248960f7f456a1d28412db7c1fdc478aeb69e544f5b7d8a97c88a20d43bca107f054c5c64c4ea8b12bebb611b20bacbfccc1bafdeba19ce5913b4832185fa4a2e5c42310f2b96a175b/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep1-en.srt&title-1=Breaking Bad S4 EP1&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s4-ep2", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 4 Episode 2",
        video: "series.html?source=https://ag.bigtimedelivery.net/_v13/b3dc503fa7df37b5dba5cfb30bd3b8ce0855a79b72d0989a4bd0d3198e7e5de0665917475b6f76656a0d3ee68c0d1782f89a0b1c5a2d3240fc9357fa4c2f26cd5b3be6bbe52d6b6bb7bb0fe2cbd6e681887dba97f81e3dcb79e383cda15e4ccae0e8115e3365bbb0dde0f92ffe10a03aaecb9200b3baf64aaedf89c734486fe46378a775c6eccf0c101998a15c233795/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep2-en.srt&title-1=Breaking Bad S4 EP2&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ag.bigtimedelivery.net/_v13/b3dc503fa7df37b5dba5cfb30bd3b8ce0855a79b72d0989a4bd0d3198e7e5de0665917475b6f76656a0d3ee68c0d1782f89a0b1c5a2d3240fc9357fa4c2f26cd5b3be6bbe52d6b6bb7bb0fe2cbd6e681887dba97f81e3dcb79e383cda15e4ccae0e8115e3365bbb0dde0f92ffe10a03aaecb9200b3baf64aaedf89c734486fe46378a775c6eccf0c101998a15c233795/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep2-en.srt&title-1=Breaking Bad S4 EP2&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s4-ep3", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 4 Episode 3",
        video: "series.html?source=https://ag.bigtimedelivery.net/_v13/b3dc503fa7df37b5dba5cfb30bd3b8ce0855a79b72d0989a4bd0d3198e7e5de0665917475b6f76656a0d3ee68c0d1782f89a0b1c5a2d3240fc9357fa4c2f26cd5b3be6bbe52d6b6bb7bb0fe2cbd6e681887dba97f81e3dcb79e383cda15e4ccae0e8115e3365bbb0dde0f92ffe10a03aaecb9200b3baf64aaedf89c734486fe46378a775c6eccf0c101998a15c233795/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep3-en.srt&title-1=Breaking Bad S4 EP3&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ag.bigtimedelivery.net/_v13/b3dc503fa7df37b5dba5cfb30bd3b8ce0855a79b72d0989a4bd0d3198e7e5de0665917475b6f76656a0d3ee68c0d1782f89a0b1c5a2d3240fc9357fa4c2f26cd5b3be6bbe52d6b6bb7bb0fe2cbd6e681887dba97f81e3dcb79e383cda15e4ccae0e8115e3365bbb0dde0f92ffe10a03aaecb9200b3baf64aaedf89c734486fe46378a775c6eccf0c101998a15c233795/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep3-en.srt&title-1=Breaking Bad S4 EP3&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s4-ep4", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 4 Episode 4",
        video: "series.html?source=https://ad.bigtimedelivery.net/_v13/704cab4a89fbfe00fda14c71774a94d2fbbaa26fbe52b1d7260492a7f74d75cd5f8435aba689e7e369428805a178d960cfbadc3e607a953dd4b6c5956f9ead7aa7ce2731edc5bfc4f5f1b0730939eefbdae2aea8a40d6bbfccecbc7b52bfc6696d3349e3a6ae1b2b829282f8f8c0e72fb25a23a3eb669b133f034de7bae39ca90298cfea26e7acbff458c7b7034a8ae8/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep4-en.srt&title-1=Breaking Bad S4 EP4&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/704cab4a89fbfe00fda14c71774a94d2fbbaa26fbe52b1d7260492a7f74d75cd5f8435aba689e7e369428805a178d960cfbadc3e607a953dd4b6c5956f9ead7aa7ce2731edc5bfc4f5f1b0730939eefbdae2aea8a40d6bbfccecbc7b52bfc6696d3349e3a6ae1b2b829282f8f8c0e72fb25a23a3eb669b133f034de7bae39ca90298cfea26e7acbff458c7b7034a8ae8/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep4-en.srt&title-1=Breaking Bad S4 EP4&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s4-ep5", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 4 Episode 5",
        video: "series.html?source=https://ad.bigtimedelivery.net/_v13/4863efc607ef910cc681e56a1ed5c6c594af31614abdc69769c244308c24786fef735acde61d15ce759a8bd89f71d7e277762e699dc2266093b12069a7d76f2971ae5487c097c0be5551485922215efbf160e5b6a4d3e78b65f1a55e9011d2d5877515281bb00851a50e95e88200f58df60e7466b02467b94a5be43f39afa64b625bc39c0493855a54d7a1319cbbb9df/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep5-en.srt&title-1=Breaking Bad S4 EP5&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/4863efc607ef910cc681e56a1ed5c6c594af31614abdc69769c244308c24786fef735acde61d15ce759a8bd89f71d7e277762e699dc2266093b12069a7d76f2971ae5487c097c0be5551485922215efbf160e5b6a4d3e78b65f1a55e9011d2d5877515281bb00851a50e95e88200f58df60e7466b02467b94a5be43f39afa64b625bc39c0493855a54d7a1319cbbb9df/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep5-en.srt&title-1=Breaking Bad S4 EP5&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s4-ep6", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 4 Episode 6",
        video: "series.html?source=https://ah.bigtimedelivery.net/_v13/f378e035a3f9f9c16ff31b6824de1ca403a8004360edd51fc884d8ae18ed77440d984f55938adb8489857459aaaa9bb63ee66c9cfd5dc1c440673ceee7b12d2011ed75cc7b66273197566a78383ae94971abfe46090e102eedb2a2ce992de4fe4488b902b002ed2ee415223ce9be380433547e00e846df87851cafca2ab9f6184e49a7166c13667ea0fe1000da4e3e70/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep6-en.srt&title-1=Breaking Bad S4 EP6&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ah.bigtimedelivery.net/_v13/f378e035a3f9f9c16ff31b6824de1ca403a8004360edd51fc884d8ae18ed77440d984f55938adb8489857459aaaa9bb63ee66c9cfd5dc1c440673ceee7b12d2011ed75cc7b66273197566a78383ae94971abfe46090e102eedb2a2ce992de4fe4488b902b002ed2ee415223ce9be380433547e00e846df87851cafca2ab9f6184e49a7166c13667ea0fe1000da4e3e70/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep6-en.srt&title-1=Breaking Bad S4 EP6&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s4-ep7", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 4 Episode 7",
        video: "series.html?source=https://ac.bigtimedelivery.net/_v13/36199de4dd777a3a9fef459a6aaa94f881b9e8a76a06c2e4d282f592a7d9cc0f0b5c1ded73e09be8d13aa2b0e0e7100d4783c930c7997059079d9e104b150179e448ab3ee26f25c8ceb2b1ca5122a3461b7481b0b83fbb4c0aab50b7c97370752121b81665a8c0160020ccec966f83a3754774bb4b18827b560c9225fbc6e796be163709a655403ad73f2354b18bfe8b/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep7-en.srt&title-1=Breaking Bad S4 EP7&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ac.bigtimedelivery.net/_v13/36199de4dd777a3a9fef459a6aaa94f881b9e8a76a06c2e4d282f592a7d9cc0f0b5c1ded73e09be8d13aa2b0e0e7100d4783c930c7997059079d9e104b150179e448ab3ee26f25c8ceb2b1ca5122a3461b7481b0b83fbb4c0aab50b7c97370752121b81665a8c0160020ccec966f83a3754774bb4b18827b560c9225fbc6e796be163709a655403ad73f2354b18bfe8b/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep7-en.srt&title-1=Breaking Bad S4 EP7&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s4-ep8", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 4 Episode 8",
        video: "series.html?source=https://ac.bigtimedelivery.net/_v13/76aee2c8d35caa431bef92d7a1ab85b3b2de6f1e16cc90613e9d056daa5dcc7428ebd01744714ac1c4baa3ad7d43191443796a7ab59106ad48e26b0a8d80fea67675074d17610745b1043997f4a67fa3769cfd741c2b4a0974a084caf914ba74fe9c67686764c040ea1ec81fff9b638a3b9d5460616d74c5f92e36c2f79ee3b41a617c61c92b4f6fbf0aef064517543a/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep8-en.srt&title-1=Breaking Bad S4 EP8&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ac.bigtimedelivery.net/_v13/76aee2c8d35caa431bef92d7a1ab85b3b2de6f1e16cc90613e9d056daa5dcc7428ebd01744714ac1c4baa3ad7d43191443796a7ab59106ad48e26b0a8d80fea67675074d17610745b1043997f4a67fa3769cfd741c2b4a0974a084caf914ba74fe9c67686764c040ea1ec81fff9b638a3b9d5460616d74c5f92e36c2f79ee3b41a617c61c92b4f6fbf0aef064517543a/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep8-en.srt&title-1=Breaking Bad S4 EP8&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s4-ep9", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 4 Episode 9",
        video: "series.html?source=https://ah.bigtimedelivery.net/_v13/09d4dbd4faf6b7ae7389be6f1d7e6b8b74d6756e2a78ca393699b5f4e49776d653b5a61d46f003433e8af5f3665aba20af431345c521b1e17203358d0774abc4ed37eac475c0f06b256d4909a1455f785c218b0d21f2bf6893d059105a16797825999f274ffdf6164ed5e7294b7484007b14793d6d44ea809f07285f5fe6a2a055c9657b79ce18281af6c8e696d51ba2/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep9-en.srt&title-1=Breaking Bad S4 EP9&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ah.bigtimedelivery.net/_v13/09d4dbd4faf6b7ae7389be6f1d7e6b8b74d6756e2a78ca393699b5f4e49776d653b5a61d46f003433e8af5f3665aba20af431345c521b1e17203358d0774abc4ed37eac475c0f06b256d4909a1455f785c218b0d21f2bf6893d059105a16797825999f274ffdf6164ed5e7294b7484007b14793d6d44ea809f07285f5fe6a2a055c9657b79ce18281af6c8e696d51ba2/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep9-en.srt&title-1=Breaking Bad S4 EP9&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s4-ep10", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 4 Episode 10",
        video: "series.html?source=https://ad.bigtimedelivery.net/_v13/9088a197e913a8d1dc967e17ac0d270ee958a5a7c0403f6b7705bbb91075304ab0009ac3811888f9b064d842cf12a6b514c476642d432347c401430aeb7b17a6aeb3bbf1b442a9f23adba90d54b2ce22a4a1b9620098932418a1d41900ef840d44214b64edf2d847ca5ed557ac7262fae34cb7822985fa89f513f3e4ea47e2738d4f421bbef3f1fcb72e2d002acb40ca/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep10-en.srt&title-1=Breaking Bad S4 EP10&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/9088a197e913a8d1dc967e17ac0d270ee958a5a7c0403f6b7705bbb91075304ab0009ac3811888f9b064d842cf12a6b514c476642d432347c401430aeb7b17a6aeb3bbf1b442a9f23adba90d54b2ce22a4a1b9620098932418a1d41900ef840d44214b64edf2d847ca5ed557ac7262fae34cb7822985fa89f513f3e4ea47e2738d4f421bbef3f1fcb72e2d002acb40ca/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep10-en.srt&title-1=Breaking Bad S4 EP10&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s4-ep11", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 4 Episode 11",
        video: "series.html?source=https://aj.bigtimedelivery.net/_v13/7d97329d49a78d57fcbe51a989cec9148f9ad5d3c006d06ff89cfe78d579edf0448f7d0194bcaaa721ebe4778047ee94fb9969a2bafb1e0783fb34dd628d6e2b3167242817c3d18f724adbe27f41a3869881f7c8ab100c551479293a8065a965f62410422515d14b172d1af1a48208832edf86fe6d3d10e14ef90ec126c3864a569ab4d77549f9edc95ba4c95c89db48/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep11-en.srt&title-1=Breaking Bad S4 EP11&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/7d97329d49a78d57fcbe51a989cec9148f9ad5d3c006d06ff89cfe78d579edf0448f7d0194bcaaa721ebe4778047ee94fb9969a2bafb1e0783fb34dd628d6e2b3167242817c3d18f724adbe27f41a3869881f7c8ab100c551479293a8065a965f62410422515d14b172d1af1a48208832edf86fe6d3d10e14ef90ec126c3864a569ab4d77549f9edc95ba4c95c89db48/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep11-en.srt&title-1=Breaking Bad S4 EP11&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s4-ep12", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 4 Episode 12",
        video: "series.html?source=https://aj.bigtimedelivery.net/_v13/a3e819d171f5d739a87939c528d6708d025c98970628092da31d65685f4e14217e3e040fd89f8e949522709dfcc94e366b3310efe56934f6d5072c295ff39e166fa46659b9852129f7b9feba15a3cf490db8c694fd7f3a9c8e07a4ed3cd24527abd177c7a0eb2cd3da1f37832d767cd60504c03f3e4b32bb904087254de56f43ee914ee3caccb1d1fb465702bfc279ec/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep12-en.srt&title-1=Breaking Bad S4 EP12&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/a3e819d171f5d739a87939c528d6708d025c98970628092da31d65685f4e14217e3e040fd89f8e949522709dfcc94e366b3310efe56934f6d5072c295ff39e166fa46659b9852129f7b9feba15a3cf490db8c694fd7f3a9c8e07a4ed3cd24527abd177c7a0eb2cd3da1f37832d767cd60504c03f3e4b32bb904087254de56f43ee914ee3caccb1d1fb465702bfc279ec/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep12-en.srt&title-1=Breaking Bad S4 EP12&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s4-ep13", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 4 Episode 13",
        video: "series.html?source=https://ad.bigtimedelivery.net/_v13/f69944ce72c314ea486ffc8cd866f0254a755ae335d10b0d4f708f75a98e23d1d055bf038074167481bbdddca391c0258108bddd09a84b2879d5d519dcc7825036c867c842c1922437cba0593bc4b97c0152af7e3ea1c1a0fd146d8b64c903144a7e48951507067b6db78d5be26457dc7768e0e0527baa3507b477877269ce68a85ea229271a252e8645e8bc71678326/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep13-en.srt&title-1=Breaking Bad S4 EP13&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/f69944ce72c314ea486ffc8cd866f0254a755ae335d10b0d4f708f75a98e23d1d055bf038074167481bbdddca391c0258108bddd09a84b2879d5d519dcc7825036c867c842c1922437cba0593bc4b97c0152af7e3ea1c1a0fd146d8b64c903144a7e48951507067b6db78d5be26457dc7768e0e0527baa3507b477877269ce68a85ea229271a252e8645e8bc71678326/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s4-ep13-en.srt&title-1=Breaking Bad S4 EP13&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    // Breaking Bad Season 5
    mapRedirect(["breaking-bad-s5-ep1", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 1",
        video: "series.html?source=https://ab.bigtimedelivery.net/_v13/87e65cf7aa0c1b3bf89222892f541641c66107190c1a4ad478adb3562af279bc67a937d3c7532c6a51df70f26660c7965bc7163f1ad3941bef4ae688742da11d0cd5d202658589351414311c43f618e123ce082ca40920d6ca0b1aea7cc8298e24fee2145550d19937b014f4c4388256a6069985f6b0aae711dec28e44e996baf57a84ff7ea7c2512c51b3d9fa278270/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep1-en.srt&title-1=Breaking Bad S5 EP1&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ab.bigtimedelivery.net/_v13/87e65cf7aa0c1b3bf89222892f541641c66107190c1a4ad478adb3562af279bc67a937d3c7532c6a51df70f26660c7965bc7163f1ad3941bef4ae688742da11d0cd5d202658589351414311c43f618e123ce082ca40920d6ca0b1aea7cc8298e24fee2145550d19937b014f4c4388256a6069985f6b0aae711dec28e44e996baf57a84ff7ea7c2512c51b3d9fa278270/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep1-en.srt&title-1=Breaking Bad S5 EP1&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s5-ep2", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 2",
        video: "series.html?source=https://ad.bigtimedelivery.net/_v13/9f83f5fe1f98dfac2967f7bc624497eef0c4c4709269a7d7f4c14d5ecf9f5b6c337f9ccaa1eabedd3f0fc8eeaca29c39f1621cc1d1c4c85b23e003a6e0a879c8931f7b0367ad16e777ccee536fabeda468a820c6e363692766cc04349f804a377a2a3b4046ad19fe8ea738cfed78da8500677456b21f0f0241ec5833c0cb5dea5823bd1e14c5b30d5564aaaf43129fa0/360/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep2-en.srt&title-1=Breaking Bad S5 EP2&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/9f83f5fe1f98dfac2967f7bc624497eef0c4c4709269a7d7f4c14d5ecf9f5b6c337f9ccaa1eabedd3f0fc8eeaca29c39f1621cc1d1c4c85b23e003a6e0a879c8931f7b0367ad16e777ccee536fabeda468a820c6e363692766cc04349f804a377a2a3b4046ad19fe8ea738cfed78da8500677456b21f0f0241ec5833c0cb5dea5823bd1e14c5b30d5564aaaf43129fa0/360/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep2-en.srt&title-1=Breaking Bad S5 EP2&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s5-ep3", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 3",
        video: "series.html?source=https://ah.bigtimedelivery.net/_v13/4398a974af012033ce34dc9b879ef68ca4c2ea7b328af961791722e89eafbc63fdd1dd24ec236dd37cb40863497157b7a6995be2dda6d58ed92fbe8ab6df7c9f51f70dcab3b3034e627ea2d21d500714fd60d472e71df63f3b623cf2bfd1a7ef119bf9dd143fee7a5acee6c1ad6d82011ba904aa9b485f475359dfab548e818b09fa12ea7c710fb25fe7ba557e873158/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep3-en.srt&title-1=Breaking Bad S5 EP3&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ah.bigtimedelivery.net/_v13/4398a974af012033ce34dc9b879ef68ca4c2ea7b328af961791722e89eafbc63fdd1dd24ec236dd37cb40863497157b7a6995be2dda6d58ed92fbe8ab6df7c9f51f70dcab3b3034e627ea2d21d500714fd60d472e71df63f3b623cf2bfd1a7ef119bf9dd143fee7a5acee6c1ad6d82011ba904aa9b485f475359dfab548e818b09fa12ea7c710fb25fe7ba557e873158/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep3-en.srt&title-1=Breaking Bad S5 EP3&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s5-ep4", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 4",
        video: "series.html?source=https://aa.bigtimedelivery.net/_v13/ca93c41b350849d032d5681a697f5ee0b3c9d3bd42aa060a4d0afd2d7ddfbbada31e646ede8d2272e5add72be8da69333fc9144c0052be6f804509471db024783c584ada47610fa199a6e5c845076700a3d4d63db824515965741c914cd227a3890c1bbfcb5036470afa5624b6fdfd9c515c94aed00b8009319c66878d01c66efb02443e2a7bf496c720268c0c4225a7/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep4-en.srt&title-1=Breaking Bad S5 EP4&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/ca93c41b350849d032d5681a697f5ee0b3c9d3bd42aa060a4d0afd2d7ddfbbada31e646ede8d2272e5add72be8da69333fc9144c0052be6f804509471db024783c584ada47610fa199a6e5c845076700a3d4d63db824515965741c914cd227a3890c1bbfcb5036470afa5624b6fdfd9c515c94aed00b8009319c66878d01c66efb02443e2a7bf496c720268c0c4225a7/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep4-en.srt&title-1=Breaking Bad S5 EP4&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s5-ep5", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 5",
        video: "series.html?source=https://af.bigtimedelivery.net/_v13/6154ad27a8fc9dbca67099a4bbeb04fd7d4b8fee7aa9166c73132614b0c80d11d2fa571a28f312ecc6a6b4f258346ca83d9e1bd58dc8c242d1117fc96d8ea5daddbc87d055c8963b7785b00bfbe30c0a3c2a1b0e0997188a3503ab85c3360c460272d4edf8f0233687faed67bd32adf7c40f5f19ac0aa333eb83d79574c616837143e7b6eaf0822419b6fb6930999701/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep5-en.srt&title-1=Breaking Bad S5 EP5&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://af.bigtimedelivery.net/_v13/6154ad27a8fc9dbca67099a4bbeb04fd7d4b8fee7aa9166c73132614b0c80d11d2fa571a28f312ecc6a6b4f258346ca83d9e1bd58dc8c242d1117fc96d8ea5daddbc87d055c8963b7785b00bfbe30c0a3c2a1b0e0997188a3503ab85c3360c460272d4edf8f0233687faed67bd32adf7c40f5f19ac0aa333eb83d79574c616837143e7b6eaf0822419b6fb6930999701/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep5-en.srt&title-1=Breaking Bad S5 EP5&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s5-ep6", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 6",
        video: "series.html?source=https://ad.bigtimedelivery.net/_v13/39cff55eed00824d4f04a6111645ebb6294cc11a6a48bdabb7f1c0f2b7a517defc8c9a16fcc97b36138ca7cc470eb32758a2e850539ed51dc6731fd0ab94076ab95f0af9b47ab6c526e52e1fff2a46ca19924122a37e3162026ae68e54db234958911071c0d1cc0385e705a4308a175a367791fec4e955bd4a8d5d6f893a03242643106c4756c874ce1586e6da41d9e0/1080/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep6-en.srt&title-1=Breaking Bad S5 EP6&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/39cff55eed00824d4f04a6111645ebb6294cc11a6a48bdabb7f1c0f2b7a517defc8c9a16fcc97b36138ca7cc470eb32758a2e850539ed51dc6731fd0ab94076ab95f0af9b47ab6c526e52e1fff2a46ca19924122a37e3162026ae68e54db234958911071c0d1cc0385e705a4308a175a367791fec4e955bd4a8d5d6f893a03242643106c4756c874ce1586e6da41d9e0/1080/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep6-en.srt&title-1=Breaking Bad S5 EP6&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s5-ep7", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 7",
        video: "series.html?source=https://ai.bigtimedelivery.net/_v13/76a39d8fdc08c6c45a11edf4e5c5143e04e730c26a0cb0db8201337d407163573819068aaf4e5b0e647d9fa5a7eb603a629ff38b05f671e317eb8a4f997ad67e3f6eae15f18b54dcb38577b7080ca27c19dd387e5ceadb2623b8e2228b805ece822e0557609e67bf0256503ea02e37271c44c23acd2ac1ba7f80e75bd73394b49a534423a9555720e5b6020cd5ef866d/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep7-en.srt&title-1=Breaking Bad S5 EP7&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ai.bigtimedelivery.net/_v13/76a39d8fdc08c6c45a11edf4e5c5143e04e730c26a0cb0db8201337d407163573819068aaf4e5b0e647d9fa5a7eb603a629ff38b05f671e317eb8a4f997ad67e3f6eae15f18b54dcb38577b7080ca27c19dd387e5ceadb2623b8e2228b805ece822e0557609e67bf0256503ea02e37271c44c23acd2ac1ba7f80e75bd73394b49a534423a9555720e5b6020cd5ef866d/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep7-en.srt&title-1=Breaking Bad S5 EP7&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s5-ep8", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 8",
        video: "series.html?source=https://aa.bigtimedelivery.net/_v13/48d73040336a344dbd4db7679c1df13ea2b18831d97dd22f8ea9e3e4ea2e2a3ff930121a1034ff99524c25cb962c7dcd8a8be4eb54821c7a21a5009c285bb010d32b2f99ac0cce562146c34c6d622239c41b21d49a1093d5130a500031ecfb7e45e3f84f296b58bcb40c5fa9b9b2e47e328247ecb27081db419852df9a44482fb73eea068275e0fca929718b98dd9a60/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep8-en.srt&title-1=Breaking Bad S5 EP8&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/48d73040336a344dbd4db7679c1df13ea2b18831d97dd22f8ea9e3e4ea2e2a3ff930121a1034ff99524c25cb962c7dcd8a8be4eb54821c7a21a5009c285bb010d32b2f99ac0cce562146c34c6d622239c41b21d49a1093d5130a500031ecfb7e45e3f84f296b58bcb40c5fa9b9b2e47e328247ecb27081db419852df9a44482fb73eea068275e0fca929718b98dd9a60/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep8-en.srt&title-1=Breaking Bad S5 EP8&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s5-ep9", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 9",
        video: "series.html?source=https://ae.bigtimedelivery.net/_v13/f3217744086b22e1b8852b974202ed7fbd737189f5a8817362bd51438b2d6983a73d8dbb3698645b91d4acec5daba23d439a43de14a3cd518377c4eff150b5e7b582b2632739bff2a3be5ec2d3b8c9fefceef791aa241c1473299f448b23ec0819e7919960f7be1905ab9f93bce9a7dc97d0220f1f7f256bcb064899dffe0f0648fe9eff346cab22d9409f6f051bc1bc/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep9-en.srt&title-1=Breaking Bad S5 EP9&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ae.bigtimedelivery.net/_v13/f3217744086b22e1b8852b974202ed7fbd737189f5a8817362bd51438b2d6983a73d8dbb3698645b91d4acec5daba23d439a43de14a3cd518377c4eff150b5e7b582b2632739bff2a3be5ec2d3b8c9fefceef791aa241c1473299f448b23ec0819e7919960f7be1905ab9f93bce9a7dc97d0220f1f7f256bcb064899dffe0f0648fe9eff346cab22d9409f6f051bc1bc/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep9-en.srt&title-1=Breaking Bad S5 EP9&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s5-ep10", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 10",
        video: "series.html?source=https://ai.bigtimedelivery.net/_v13/57a22898716dbff4c80f6391771116851ac7d4ba87220d1ed78dffbe836437fdacf1a1b0454208d7cc53669036467734b5c5918a268530c77eed2c56d24028690f9526935686bf4ab0194c37f44d96de742d82e5df12ead15802662190b63202239f22fae10ab0b2ac8325c64071289ca9cf1254d5bf90d5beab2a8030bb167a8ba08516461b747b260137bc1f6810c4/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep10-en.srt&title-1=Breaking Bad S5 EP10&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ai.bigtimedelivery.net/_v13/57a22898716dbff4c80f6391771116851ac7d4ba87220d1ed78dffbe836437fdacf1a1b0454208d7cc53669036467734b5c5918a268530c77eed2c56d24028690f9526935686bf4ab0194c37f44d96de742d82e5df12ead15802662190b63202239f22fae10ab0b2ac8325c64071289ca9cf1254d5bf90d5beab2a8030bb167a8ba08516461b747b260137bc1f6810c4/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep10-en.srt&title-1=Breaking Bad S5 EP10&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s5-ep11", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 11",
        video: "series.html?source=https://ad.bigtimedelivery.net/_v13/7b99e80f36106538582149b24281b5a4ec06ce7111a59997f9a8edc3c07477094e0e52c63f4b6edf113b12abd46dc9eeb303df738dff1e42a0ee9752a9b597ce38f0f01f7d3f64108a5e1dcf88e9ba75c73d03beb72d6d604796517ebe5383d0e886cf2c2dd144a7efd26351ae501867180fd279868db55f1315e7cd39648768f72278aa26d850f213b6cae2087d0c51/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep11-en.srt&title-1=Breaking Bad S5 EP11&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/7b99e80f36106538582149b24281b5a4ec06ce7111a59997f9a8edc3c07477094e0e52c63f4b6edf113b12abd46dc9eeb303df738dff1e42a0ee9752a9b597ce38f0f01f7d3f64108a5e1dcf88e9ba75c73d03beb72d6d604796517ebe5383d0e886cf2c2dd144a7efd26351ae501867180fd279868db55f1315e7cd39648768f72278aa26d850f213b6cae2087d0c51/720/index.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep11-en.srt&title-1=Breaking Bad S5 EP11&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s5-ep12", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 12",
        video: "series.html?source=https://ad.bigtimedelivery.net/_v13/98e238e0668418e27fd3b50e51b47a86bb3c7ddaf298638568672656affc1dd6164b79bb7a9bdc11a26715abb0b6770e1b1e77f96b75f7576758906217d1d9a3f0a60993d97e7130533e5030f1fd44ff0f15266092d9c115ec4311c4b48fe03b389640eff785a50791ab05082a9465e4340702f514c30536ec2408dd3384663068dbca81cb07148589002a0cfd41f36c/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep12-en.srt&title-1=Breaking Bad S5 EP12&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ad.bigtimedelivery.net/_v13/98e238e0668418e27fd3b50e51b47a86bb3c7ddaf298638568672656affc1dd6164b79bb7a9bdc11a26715abb0b6770e1b1e77f96b75f7576758906217d1d9a3f0a60993d97e7130533e5030f1fd44ff0f15266092d9c115ec4311c4b48fe03b389640eff785a50791ab05082a9465e4340702f514c30536ec2408dd3384663068dbca81cb07148589002a0cfd41f36c/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep12-en.srt&title-1=Breaking Bad S5 EP12&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s5-ep13", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 13",
        video: "series.html?source=https://aj.bigtimedelivery.net/_v13/2ea80a53d5645a370c2779c0e3933b13f6295037b857d687c981903fddf49f6bcbe45b3c4e8717c2fdab73cdd8a4d8c4ae80becd0f07e950abe29021a5b6db52118be3e7b4e0e641057cd176b3a2598b2ea29e11e538e5c28711fb1bae107e11b0eb5c38ac2d722ca5c43c0d7eacd980b8d8aaab7b909b13ae09ff173cc0b3e7eb3e969d3858e5b27f646cfc978fe39d/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep13-en.srt&title-1=Breaking Bad S5 EP13&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aj.bigtimedelivery.net/_v13/2ea80a53d5645a370c2779c0e3933b13f6295037b857d687c981903fddf49f6bcbe45b3c4e8717c2fdab73cdd8a4d8c4ae80becd0f07e950abe29021a5b6db52118be3e7b4e0e641057cd176b3a2598b2ea29e11e538e5c28711fb1bae107e11b0eb5c38ac2d722ca5c43c0d7eacd980b8d8aaab7b909b13ae09ff173cc0b3e7eb3e969d3858e5b27f646cfc978fe39d/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep13-en.srt&title-1=Breaking Bad S5 EP13&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s5-ep14", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 14",
        video: "series.html?source=https://ai.bigtimedelivery.net/_v13/c7874d9b3714611f1c0a23c8851315bb24f34de70a389679cc2259b1b7262ecadfe4aeb2c3da5cd3a880bf18acedfddd9b8ce40df7e5e046a5ee55a9e0cdbf7299ef8cc142e6d5193aabdcabfbe33163790cb474ad2d43c24e6e08f1020e1f5dd5d323ccb683e4366384371a2841809f789acdf6f2503c3152909f8c33c1ba0ebed831357ce45ee2f9b90bcc195a2e1c/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep14-en.srt&title-1=Breaking Bad S5 EP14&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ai.bigtimedelivery.net/_v13/c7874d9b3714611f1c0a23c8851315bb24f34de70a389679cc2259b1b7262ecadfe4aeb2c3da5cd3a880bf18acedfddd9b8ce40df7e5e046a5ee55a9e0cdbf7299ef8cc142e6d5193aabdcabfbe33163790cb474ad2d43c24e6e08f1020e1f5dd5d323ccb683e4366384371a2841809f789acdf6f2503c3152909f8c33c1ba0ebed831357ce45ee2f9b90bcc195a2e1c/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep14-en.srt&title-1=Breaking Bad S5 EP14&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s5-ep15", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 15",
        video: "series.html?source=https://aa.bigtimedelivery.net/_v13/a3d3ad3db37d1e02bcc4544f2dfd16564a5e01da92d9091e78e6ee0861d8da9e478a8bf5d776d826d51653a02221c41c6f5658ce4d47f0bc78bfda6d6205cfde3d5914cb5f88f0cc2b965f5ebb61bd455c54609283e715a20428d15fedc94b58b801c9d90e6ce92c826a982b3fbb9be94e625b33d42a3b8c628f95368c55bd3df699db955d031a4d443cc79b721b58ab/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep15-en.srt&title-1=Breaking Bad S5 EP15&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://aa.bigtimedelivery.net/_v13/a3d3ad3db37d1e02bcc4544f2dfd16564a5e01da92d9091e78e6ee0861d8da9e478a8bf5d776d826d51653a02221c41c6f5658ce4d47f0bc78bfda6d6205cfde3d5914cb5f88f0cc2b965f5ebb61bd455c54609283e715a20428d15fedc94b58b801c9d90e6ce92c826a982b3fbb9be94e625b33d42a3b8c628f95368c55bd3df699db955d031a4d443cc79b721b58ab/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep15-en.srt&title-1=Breaking Bad S5 EP15&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),
    mapRedirect(["breaking-bad-s5-ep16", ""], {
        splashimgurl: "https://image.tmdb.org/t/p/original/EurcYIB7obJgoVzeui2RZkFlEm.jpg",
        title: "Watch Breaking Bad Season 5 Episode 16",
        video: "series.html?source=https://ac.bigtimedelivery.net/_v13/9ea6ff6276e7d6d322ce6ec4ac3286d5750b6a0251007f2ff35504108246ad16b0877098eeb157d94445c16646d81dd08e8607b5593a58672834f5a810f5e43f809cce95f02b788c409554096f194d5d05672cd6c101a4e5f8170bc2c841a4db60fa7a57963a799b6d96900800b313ad2dc473ba1d07bb006cb78fb26eea7e35dc3a045df89ec2e29217120bdc24f703/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep16-en.srt&title-1=Breaking Bad S5 EP16&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
        video2: "series2.html?source=https://ac.bigtimedelivery.net/_v13/9ea6ff6276e7d6d322ce6ec4ac3286d5750b6a0251007f2ff35504108246ad16b0877098eeb157d94445c16646d81dd08e8607b5593a58672834f5a810f5e43f809cce95f02b788c409554096f194d5d05672cd6c101a4e5f8170bc2c841a4db60fa7a57963a799b6d96900800b313ad2dc473ba1d07bb006cb78fb26eea7e35dc3a045df89ec2e29217120bdc24f703/playlist.m3u8&subcode=en&substitleurl=substitles/series/breaking-bad/breaking-bad-s5-ep16-en.srt&title-1=Breaking Bad S5 EP16&img=https://image.tmdb.org/t/p/original/wKHImjeHwVIiWJWFIJtWUKkA5QJ.jpg",
    }),

// Function to parse URL parameters
function parseUrlParams() {
    const params = {};
    const urlParams = new URLSearchParams(window.location.search);
    for (const [key, value] of urlParams) {
        params[key] = value;
    }
    return params;
}

// Function to update HTML elements with fetched data
function updateHtmlElements(data) {
    const imgElement = document.getElementById('splash-img');
    const titleElement = document.getElementById('video-title');
    const videoFrameElement = document.getElementById('video-frame');
    const videoFrame2Element = document.getElementById('video-frame2');
    const descriptionElement = document.getElementById('ptag');
    const downloadLinkElement = document.getElementById('download-link');

    if (data.splashimgurl && imgElement) {
        imgElement.src = decodeURIComponent(data.splashimgurl);
    }
    if (data.title && titleElement) {
        titleElement.textContent = decodeURIComponent(data.title);
        document.title = decodeURIComponent(data.title); // Set page title dynamically
    }
    if (data.video && videoFrameElement) {
        videoFrameElement.src = decodeURIComponent(data.video);
    }
    if (data.video2 && videoFrame2Element) {
        videoFrame2Element.src = decodeURIComponent(data.video2);
    }
    if (data.para && descriptionElement) {
        descriptionElement.textContent = decodeURIComponent(data.para);
    }
    if (data.download && data.enableDownload === true && downloadLinkElement) { // Check if download is enabled
        downloadLinkElement.href = decodeURIComponent(data.download);
        downloadLinkElement.textContent = "Download"; // Set desired text for download link
        downloadLinkElement.style.display = 'block'; // Show download link
    } else if (downloadLinkElement) {
        downloadLinkElement.style.display = 'none'; // Hide download link if download is not enabled
    }
}


window.addEventListener('load', function() {
    const videoFrame2Element = document.getElementById('video-frame2');
    if (videoFrame2Element) {
        videoFrame2Element.onerror = function() {
            console.log('Error loading main video, setting fallback.');
            setFallback();
        };
        const params = parseUrlParams();
        const pageId = params['id'];
        if (pageId && redirects.hasOwnProperty(pageId)) {
            const data = redirects[pageId];
            videoFrame2Element.src = decodeURIComponent(data.video2 || data.fallback || '');
        } else {
            console.error('Invalid id parameter or no redirect data found.');
        }
    } else {
        console.error('video-frame2 element not found.');
    }
});



// Function to handle page load
function handlePageLoad() {
    const params = parseUrlParams();
    const pageId = params['id'];

    if (pageId && redirects.hasOwnProperty(pageId)) {
        updateHtmlElements(redirects[pageId]);
    } else {
        console.error('Invalid id parameter provided.');
        // Ensure all elements are shown even if id is missing or invalid
        const titleElement = document.getElementById('video-title');
        const videoFrameElement = document.getElementById('video-frame');
        const videoFrame2Element = document.getElementById('video-frame2');
        if (titleElement) {
            titleElement.style.display = 'block';
        }
        if (videoFrameElement) {
            videoFrameElement.style.display = 'block';
        }
        if (videoFrame2Element) {
            videoFrame2Element.style.display = 'block';
        }
    }
}

window.addEventListener('load', handlePageLoad);
