USE CarMarketDB;
GO

INSERT INTO Brand (name, country) VALUES
-- ==================== ایران ====================
(N'ایران خودرو', N'ایران'),
(N'سایپا', N'ایران'),
(N'بهمن', N'ایران'),
(N'مدیران خودرو', N'ایران'),
(N'رامین', N'ایران'),
(N'کیان موتور', N'ایران'),
(N'آرین موتور', N'ایران'),
(N'کرمان موتور', N'ایران'),
(N'پارس خودرو', N'ایران'),
(N'فردا موتورز', N'ایران'),
(N'دیار خودرو', N'ایران'),

-- ==================== ژاپن ====================
(N'تویوتا', N'ژاپن'),
(N'هوندا', N'ژاپن'), 
(N'نیسان', N'ژاپن'),
(N'مزدا', N'ژاپن'),
(N'سوزوکی', N'ژاپن'), 
(N'میتسوبیشی', N'ژاپن'),
(N'لکسوس', N'ژاپن'),
(N'سوبارو', N'ژاپن'),
(N'ایسوزو', N'ژاپن'),
(N'دایهاتسو', N'ژاپن'),
(N'اینفینیتی', N'ژاپن'),      -- برند لوکس نیسان
(N'آکورا', N'ژاپن'),          -- برند لوکس هوندا
(N'هینو', N'ژاپن'),           -- کامیون‌سازی
(N'یو دی تراکس', N'ژاپن'),    -- UD Trucks

-- ==================== کره جنوبی ====================
(N'هیوندای', N'کره جنوبی'),
(N'کیا', N'کره جنوبی'),
(N'جنسیس', N'کره جنوبی'),
(N'دوو', N'کره جنوبی'),
(N'سانگیونگ', N'کره جنوبی'),

-- ==================== چین ====================
(N'چری', N'چین'),
(N'ام‌وی‌ام', N'چین'),
(N'لیفان', N'چین'),
(N'جیلی', N'چین'),
(N'هایما', N'چین'),
(N'برلیانس', N'چین'),
(N'دانگ فنگ', N'چین'),
(N'فوتون', N'چین'), 
(N'جک', N'چین'),
(N'بایک', N'چین'),
(N'ب‌وای‌دی', N'چین'),
(N'گریت وال', N'چین'),
(N'چانگان', N'چین'),
(N'هوال', N'چین'),
(N'ام‌جی', N'چین'),
(N'فاو', N'چین'),             -- اولین خودروساز چین
(N'نیو', N'چین'),             -- NIO (خودرو برقی لوکس)
(N'ژیپنگ', N'چین'),           -- XPeng
(N'لی اتو', N'چین'),          -- Li Auto
(N'زیکر', N'چین'),            -- Zeekr
(N'لینک اند کو', N'چین'),     -- Lynk & Co
(N'هونگچی', N'چین'),          -- Hongqi (برند تشریفاتی)
(N'رووی', N'چین'),            -- Roewe
(N'گاک', N'چین'),             -- GAC Group
(N'ایون', N'چین'),            -- Aion

-- ==================== آلمان ====================
(N'بنز', N'آلمان'), 
(N'BMW', N'آلمان'), 
(N'آئودی', N'آلمان'),
(N'فولکس واگن', N'آلمان'),
(N'پورشه', N'آلمان'),
(N'اوپل', N'آلمان'),
(N'من', N'آلمان'),
(N'مینی', N'آلمان'),
(N'اسمارت', N'آلمان'),
(N'آلپینا', N'آلمان'),        -- تیونر BMW
(N'بورگوارد', N'آلمان'),      -- Borgward (احیا شده)
(N'ویزمن', N'آلمان'),         -- Wiesmann (اسپورت دست‌ساز)

-- ==================== آمریکا ====================
(N'فورد', N'آمریکا'),
(N'شورولت', N'آمریکا'),
(N'جیپ', N'آمریکا'),
(N'دوج', N'آمریکا'),
(N'تسلا', N'آمریکا'),
(N'کادیلاک', N'آمریکا'),
(N'لینکلن', N'آمریکا'),
(N'بیوک', N'آمریکا'),
(N'GMC', N'آمریکا'),
(N'رام', N'آمریکا'),
(N'کرایسلر', N'آمریکا'),      -- برند اصلی آمریکایی
(N'پونتیاک', N'آمریکا'),      -- منحل‌شده اما بسیار معروف
(N'اولدزموبیل', N'آمریکا'),   -- Oldsmobile
(N'ساترن', N'آمریکا'),        -- Saturn
(N'مرکوری', N'آمریکا'),       -- Mercury
(N'پلیموث', N'آمریکا'),       -- Plymouth
(N'هامِر', N'آمریکا'),        -- Hummer
(N'اسکایون', N'آمریکا'),      -- Scion (برند جوانان تویوتا در آمریکا)

-- ==================== فرانسه ====================
(N'رنو', N'فرانسه'), 
(N'پژو', N'فرانسه'),
(N'سیتروئن', N'فرانسه'),
(N'بوگاتی', N'فرانسه'),
(N'دی‌اس', N'فرانسه'),         -- DS Automobiles
(N'آلپاین', N'فرانسه'),        -- Alpine (اسپورت)

-- ==================== ایتالیا ====================
(N'فیات', N'ایتالیا'),
(N'ایوکو', N'ایتالیا'),
(N'آلفارومئو', N'ایتالیا'),
(N'مازراتی', N'ایتالیا'),
(N'فراری', N'ایتالیا'),
(N'لامبورگینی', N'ایتالیا'),
(N'لانچیا', N'ایتالیا'),       -- Lancia
(N'آبارت', N'ایتالیا'),        -- Abarth
(N'پاگانی', N'ایتالیا'),       -- Pagani (هایپراسپرت)
(N'دتوماسو', N'ایتالیا'),      -- De Tomaso

-- ==================== انگلستان ====================
(N'رنج‌روور', N'انگلستان'),
(N'جگوار', N'انگلستان'),
(N'بنتلی', N'انگلستان'),
(N'رولزرویس', N'انگلستان'),
(N'لوتوس', N'انگلستان'),
(N'لندروور', N'انگلستان'),
(N'استون مارتین', N'انگلستان'),
(N'مک‌لارن', N'انگلستان'),
(N'مورگان', N'انگلستان'),      -- Morgan
(N'تی‌وی‌آر', N'انگلستان'),    -- TVR
(N'کترینگ', N'انگلستان'),      -- Caterham
(N'واکسهال', N'انگلستان'),     -- Vauxhall
(N'آستین', N'انگلستان'),       -- Austin (تاریخی)
(N'موریس', N'انگلستان'),       -- Morris (تاریخی)
(N'تریومف', N'انگلستان'),      -- Triumph (تاریخی)

-- ==================== سوئد ====================
(N'اسکانیا', N'سوئد'), 
(N'ولوو', N'سوئد'), 
(N'ساب', N'سوئد'),             -- Saab
(N'کونیگ‌زیگ', N'سوئد'),       -- Koenigsegg (هایپراسپرت)

-- ==================== سایر کشورها ====================
(N'داچیا', N'رومانی'),
(N'اشکودا', N'جمهوری چک'),
(N'تاترا', N'جمهوری چک'),      -- Tatra (تاریخی و کامیونی)
(N'سیات', N'اسپانیا'),

-- ==================== روسیه ====================
(N'لادا', N'روسیه'),
(N'یوآز', N'روسیه'),           -- UAZ
(N'گاز', N'روسیه'),           -- GAZ
(N'کاماز', N'روسیه'),         -- Kamaz (کامیون)

-- ==================== هند ====================
(N'تاتا', N'هند'),
(N'ماهیندرا', N'هند'),
(N'ماروتی', N'هند'),          -- Maruti (معروف به ماروتی سوزوکی)

-- ==================== مالزی ====================
(N'پروتون', N'مالزی'),
(N'پرودوآ', N'مالزی'),

-- ==================== استرالیا ====================
(N'هولدن', N'استرالیا'),

-- ==================== ترکیه ====================
(N'توگ', N'ترکیه'),           -- TOGG (خودرو برقی ملی ترکیه)

-- ==================== هلند ====================
(N'اسپایکر', N'هلند'),        -- Spyker
(N'داف', N'هلند'),           -- DAF (کامیون)
(N'یاماها', N'ژاپن'),
(N'دوکاتی', N'ایتالیا'),
(N'هارلی-دیویدسون', N'آمریکا'),
(N'کی‌تی‌ام', N'اتریش'),
(N'آپریلیا', N'ایتالیا'),
(N'موتو گوتزی', N'ایتالیا'),
(N'بنلی', N'ایتالیا'),
(N'ام‌وی آگوستا', N'ایتالیا'),
(N'رویال انفیلد', N'هند'),
(N'نورتون', N'انگلستان');
GO


-- ============================================================
-- درج مدل‌های خودرو، موتورسیکلت و خودروهای سنگین
-- کاملاً پویا و مستقل از ID برندها
-- ============================================================

INSERT INTO Model (brand_id, name, category) VALUES

-- ==================== ایران ====================
((SELECT brand_id FROM Brand WHERE name=N'ایران خودرو'), N'سمند', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ایران خودرو'), N'دنا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ایران خودرو'), N'تارا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ایران خودرو'), N'پارس', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ایران خودرو'), N'۲۰۶ صندوقدار', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ایران خودرو'), N'۲۰۶ هاچ‌بک', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ایران خودرو'), N'۴۰۵', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ایران خودرو'), N'رانا', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'سایپا'), N'پراید', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'سایپا'), N'تیبا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'سایپا'), N'ساینا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'سایپا'), N'کوییک', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'سایپا'), N'شاهین', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'سایپا'), N'وانت نیسان', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'بهمن'), N'دیگنیتی', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'بهمن'), N'ریرا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'بهمن'), N'بهمن S', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'مدیران خودرو'), N'ام‌وی‌ام X33', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'مدیران خودرو'), N'ام‌وی‌ام X55', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'مدیران خودرو'), N'ام‌وی‌ام ۱۱۰', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'کرمان موتور'), N'جک J4', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'کرمان موتور'), N'جک S5', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'کرمان موتور'), N'جک J7', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'پارس خودرو'), N'هایما S5', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'پارس خودرو'), N'هایما ۷', N'car'),

-- ==================== ژاپن (خودرو) ====================
((SELECT brand_id FROM Brand WHERE name=N'تویوتا'), N'کرولا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'تویوتا'), N'کمری', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'تویوتا'), N'لندکروزر', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'تویوتا'), N'پرادو', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'تویوتا'), N'یاریس', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'تویوتا'), N'هایلوکس', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'تویوتا'), N'راوم', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'تویوتا'), N'سوپرا', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'هوندا'), N'آکورد', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هوندا'), N'سیویک', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هوندا'), N'سی‌آر-وی', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هوندا'), N'اچ‌آر-وی', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هوندا'), N'پایلوت', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'نیسان'), N'پاترول', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'نیسان'), N'قشقایی', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'نیسان'), N'سدریک', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'نیسان'), N'ماکسیما', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'نیسان'), N'تیانا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'نیسان'), N'اسکای‌لاین', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'مزدا'), N'مزدا ۳', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'مزدا'), N'مزدا ۶', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'مزدا'), N'ام‌ایکس-۵', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'مزدا'), N'سی‌ایکس-۵', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'میتسوبیشی'), N'لنسر', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'میتسوبیشی'), N'پاجرو', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'میتسوبیشی'), N'ASX', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'میتسوبیشی'), N'اکلیپس کراس', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'لکسوس'), N'LX', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لکسوس'), N'RX', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لکسوس'), N'ES', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لکسوس'), N'LS', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'سوبارو'), N'فورستر', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'سوبارو'), N'آوت‌بک', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'سوبارو'), N'WRX', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'اینفینیتی'), N'Q50', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'اینفینیتی'), N'QX60', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'اینفینیتی'), N'QX80', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'آکورا'), N'MDX', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'آکورا'), N'TLX', N'car'),

-- ==================== ژاپن (موتورسیکلت) ====================
((SELECT brand_id FROM Brand WHERE name=N'هوندا'), N'سی‌بی‌آر ۱۰۰۰آرآر', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'هوندا'), N'سی‌بی‌آر ۶۰۰آرآر', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'هوندا'), N'گلدوینگ', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'هوندا'), N'سی‌بی ۵۰۰ایکس', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'هوندا'), N'اف‌آر-وی ۷۵۰', N'motorcycle'),

((SELECT brand_id FROM Brand WHERE name=N'سوزوکی'), N'جی‌اس‌ایکس-آر ۱۰۰۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'سوزوکی'), N'جی‌اس‌ایکس-آر ۷۵۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'سوزوکی'), N'وی-استرام ۶۵۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'سوزوکی'), N'هایابوسا', N'motorcycle'),

-- ==================== ژاپن (خودروهای سنگین) ====================
((SELECT brand_id FROM Brand WHERE name=N'ایسوزو'), N'NPR', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'ایسوزو'), N'NQR', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'ایسوزو'), N'Forward', N'heavy_vehicle'),

((SELECT brand_id FROM Brand WHERE name=N'هینو'), N'سری ۵۰۰', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'هینو'), N'سری ۷۰۰', N'heavy_vehicle'),

((SELECT brand_id FROM Brand WHERE name=N'یو دی تراکس'), N'کیل', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'یو دی تراکس'), N'کندور', N'heavy_vehicle'),

-- ==================== کره جنوبی ====================
((SELECT brand_id FROM Brand WHERE name=N'هیوندای'), N'سوناتا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هیوندای'), N'الانترا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هیوندای'), N'توسان', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هیوندای'), N'سانتافه', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هیوندای'), N'آزرا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هیوندای'), N'پالیسید', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'کیا'), N'سراتو', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'کیا'), N'اسپورتیج', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'کیا'), N'تلوراید', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'کیا'), N'استینگر', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'کیا'), N'پیکانتو', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'جنسیس'), N'G70', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'جنسیس'), N'G80', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'جنسیس'), N'G90', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'دوو'), N'ماتیز', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'دوو'), N'لگانا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'دوو'), N'تیکو', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'سانگیونگ'), N'تیرون', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'سانگیونگ'), N'کراند', N'car'),

-- ==================== چین ====================
((SELECT brand_id FROM Brand WHERE name=N'چری'), N'تیگو ۷', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'چری'), N'تیگو ۵', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'چری'), N'آریزو ۶', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'چری'), N'آریزو ۵', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'چری'), N'آریزو ۸', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'جیلی'), N'جیلی ام‌روند', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'جیلی'), N'جیلی جی‌سی', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'جیلی'), N'کولری', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'جیلی'), N'اوکاوانگو', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'ب‌وای‌دی'), N'هان', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ب‌وای‌دی'), N'تانگ', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ب‌وای‌دی'), N'دولفین', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ب‌وای‌دی'), N'سِیل', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'گریت وال'), N'هاوال اچ۶', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'گریت وال'), N'هاوال اچ۹', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'گریت وال'), N'پوئر', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'هوال'), N'هاوال اچ۶', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هوال'), N'هاوال جولین', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هوال'), N'هاوال داگو', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'چانگان'), N'CS35', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'چانگان'), N'CS75', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'چانگان'), N'CS55', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'ام‌جی'), N'MG 5', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ام‌جی'), N'MG 7', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ام‌جی'), N'ZS', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'جک'), N'J4', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'جک'), N'S5', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'جک'), N'J7', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'بایک'), N'X25', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'بایک'), N'X35', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'بایک'), N'U5 Plus', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'هایما'), N'S5', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هایما'), N'۷X', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هایما'), N'۸S', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'برلیانس'), N'H530', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'برلیانس'), N'V5', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'برلیانس'), N'V3', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'دانگ فنگ'), N'AX7', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'دانگ فنگ'), N'T5', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'لیفان'), N'X60', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لیفان'), N'X50', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لیفان'), N'میا', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'ام‌وی‌ام'), N'X33', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ام‌وی‌ام'), N'X55', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ام‌وی‌ام'), N'۱۱۰', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'فاو'), N'بستون ۳۰', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فاو'), N'بستون ۵۰', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فاو'), N'بستون ۸۰', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'نیو'), N'ES6', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'نیو'), N'ES8', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'نیو'), N'ET5', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'ژیپنگ'), N'G3', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ژیپنگ'), N'P5', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ژیپنگ'), N'P7', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'لی اتو'), N'L7', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لی اتو'), N'L8', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لی اتو'), N'L9', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'زیکر'), N'001', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'زیکر'), N'009', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'هونگچی'), N'H5', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هونگچی'), N'H9', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هونگچی'), N'E-HS9', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'رووی'), N'i5', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'رووی'), N'RX5', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'گاک'), N'GS4', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'گاک'), N'GS8', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'ایون'), N'LX', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ایون'), N'V', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ایون'), N'S', N'car'),

-- ==================== چین (خودروهای سنگین) ====================
((SELECT brand_id FROM Brand WHERE name=N'فوتون'), N'آومان', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'فوتون'), N'فورلند', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'دانگ فنگ'), N'کی-سری', N'heavy_vehicle'),

-- ==================== آلمان (خودرو) ====================
((SELECT brand_id FROM Brand WHERE name=N'بنز'), N'کلاس C', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'بنز'), N'کلاس E', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'بنز'), N'کلاس S', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'بنز'), N'جی‌کلاس', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'بنز'), N'کلاس A', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'بنز'), N'کلاس GLA', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'بنز'), N'کلاس GLE', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'BMW'), N'سری ۳', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'BMW'), N'سری ۵', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'BMW'), N'سری ۷', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'BMW'), N'X3', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'BMW'), N'X5', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'BMW'), N'X7', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'BMW'), N'M3', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'BMW'), N'M5', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'آئودی'), N'A4', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'آئودی'), N'A6', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'آئودی'), N'A8', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'آئودی'), N'Q5', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'آئودی'), N'Q7', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'آئودی'), N'Q3', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'فولکس واگن'), N'گلف', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فولکس واگن'), N'پاسات', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فولکس واگن'), N'تویگون', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فولکس واگن'), N'تارگ', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فولکس واگن'), N'بتل', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'پورشه'), N'۹۱۱', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'پورشه'), N'کاین', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'پورشه'), N'ماکان', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'پورشه'), N'پانامرا', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'اوپل'), N'آسترا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'اوپل'), N'اینسیگنیا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'اوپل'), N'موکا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'اوپل'), N'کراسلند', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'مینی'), N'کوپر', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'مینی'), N'کانتری‌من', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'مینی'), N'کلاب‌من', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'اسمارت'), N'فورتو', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'اسمارت'), N'فورفور', N'car'),

-- ==================== آلمان (موتورسیکلت) ====================
((SELECT brand_id FROM Brand WHERE name=N'BMW'), N'آر ۱۲۵۰ جی‌اس', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'BMW'), N'اس ۱۰۰۰آرآر', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'BMW'), N'اف ۸۵۰ جی‌اس', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'BMW'), N'آر ۱۸', N'motorcycle'),

-- ==================== آلمان (خودروهای سنگین) ====================
((SELECT brand_id FROM Brand WHERE name=N'بنز'), N'اکتروس', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'بنز'), N'آتگو', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'بنز'), N'اسپرینتر', N'heavy_vehicle'),

((SELECT brand_id FROM Brand WHERE name=N'من'), N'TGA', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'من'), N'TGX', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'من'), N'TGS', N'heavy_vehicle'),

-- ==================== آمریکا ====================
((SELECT brand_id FROM Brand WHERE name=N'فورد'), N'فوکوس', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فورد'), N'موستانگ', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فورد'), N'افیوژن', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فورد'), N'اکسپلورر', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فورد'), N'افیونیتی', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'شورولت'), N'کروز', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'شورولت'), N'مالیبو', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'شورولت'), N'کمری', N'car'), -- Chevy Camaro
((SELECT brand_id FROM Brand WHERE name=N'شورولت'), N'تریل‌بلیزر', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'شورولت'), N'سابربن', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'جیپ'), N'رنگلر', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'جیپ'), N'چروکی', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'جیپ'), N'گرند چروکی', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'جیپ'), N'کامپس', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'دوج'), N'چارجر', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'دوج'), N'چلنجر', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'دوج'), N'رام ۱۵۰۰', N'heavy_vehicle'),

((SELECT brand_id FROM Brand WHERE name=N'تسلا'), N'مدل S', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'تسلا'), N'مدل ۳', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'تسلا'), N'مدل X', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'تسلا'), N'مدل Y', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'تسلا'), N'سایبرتراک', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'کادیلاک'), N'CT5', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'کادیلاک'), N'CT6', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'کادیلاک'), N'XT5', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'کادیلاک'), N'اسکالید', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'لینکلن'), N'ناویگیتور', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لینکلن'), N'مونت‌گو', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لینکلن'), N'کورسیر', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'بیوک'), N'انکلیو', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'بیوک'), N'ان‌ویژن', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'بیوک'), N'لاکراس', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'GMC'), N'سییرا', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'GMC'), N'ساوانا', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'GMC'), N'اکس‌یوایکس', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'رام'), N'۱۵۰۰', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'رام'), N'۲۵۰۰', N'heavy_vehicle'),

((SELECT brand_id FROM Brand WHERE name=N'کرایسلر'), N'۳۰۰', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'کرایسلر'), N'پاسیفیکا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'کرایسلر'), N'تاون اند کانتری', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'هامِر'), N'H1', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هامِر'), N'H2', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هامِر'), N'H3', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'پونتیاک'), N'جی‌تی او', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'پونتیاک'), N'فایربرد', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'اولدزموبیل'), N'کاتلاس', N'car'),

-- ==================== فرانسه ====================
((SELECT brand_id FROM Brand WHERE name=N'رنو'), N'مگان', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'رنو'), N'کلیو', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'رنو'), N'تالیسمان', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'رنو'), N'داستر', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'رنو'), N'کپچر', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'رنو'), N'آرکانا', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'پژو'), N'۲۰۶', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'پژو'), N'۲۰۷', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'پژو'), N'۴۰۵', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'پژو'), N'پارس', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'پژو'), N'۲۰۰۸', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'پژو'), N'۳۰۰۸', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'پژو'), N'۵۰۸', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'سیتروئن'), N'سی‌۳', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'سیتروئن'), N'سی‌۴', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'سیتروئن'), N'سی‌۵', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'سیتروئن'), N'برلینگو', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'دی‌اس'), N'DS 3', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'دی‌اس'), N'DS 7', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'بوگاتی'), N'ویرون', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'بوگاتی'), N'کرون', N'car'),

-- ==================== ایتالیا ====================
((SELECT brand_id FROM Brand WHERE name=N'فیات'), N'پاندا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فیات'), N'پونتو', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فیات'), N'۵۰۰', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فیات'), N'دوکاتو', N'heavy_vehicle'),

((SELECT brand_id FROM Brand WHERE name=N'آلفارومئو'), N'جولیتا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'آلفارومئو'), N'جولیا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'آلفارومئو'), N'استلویو', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'مازراتی'), N'گیبلی', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'مازراتی'), N'لوانته', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'مازراتی'), N'کواتروپورته', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'فراری'), N'اف۴۰', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فراری'), N'۴۵۸ ایتالیا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فراری'), N'پورتوفینو', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'فراری'), N'رما', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'لامبورگینی'), N'آونتادور', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لامبورگینی'), N'هوراکان', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لامبورگینی'), N'اوروس', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'پاگانی'), N'هوایرا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'پاگانی'), N'زوندا', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'ایوکو'), N'یوروکارگو', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'ایوکو'), N'دیلی', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'ایوکو'), N'استرالیس', N'heavy_vehicle'),

-- ==================== انگلستان ====================
((SELECT brand_id FROM Brand WHERE name=N'رنج‌روور'), N'ایووک', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'رنج‌روور'), N'اسپورت', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'رنج‌روور'), N'ولار', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'لندروور'), N'دیفندر', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لندروور'), N'دیسکاوری', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'جگوار'), N'ایکس‌جی', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'جگوار'), N'ایکس‌اف', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'جگوار'), N'اف-پیس', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'جگوار'), N'ای-پیس', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'بنتلی'), N'کانتیننتال', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'بنتلی'), N'فلایینگ اسپور', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'بنتلی'), N'بن‌تایگا', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'رولزرویس'), N'فانتوم', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'رولزرویس'), N'گوست', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'رولزرویس'), N'کالینان', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'استون مارتین'), N'DB11', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'استون مارتین'), N'ونتیج', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'استون مارتین'), N'دی‌بی‌اس', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'مک‌لارن'), N'۷۲۰اس', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'مک‌لارن'), N'۷۶۵ال‌تی', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'مک‌لارن'), N'آرتورا', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'لوتوس'), N'اویت', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لوتوس'), N'الیزه', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'مورگان'), N'پلاس ۴', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'مورگان'), N'پلاس ۶', N'car'),

-- ==================== سوئد ====================
((SELECT brand_id FROM Brand WHERE name=N'ولوو'), N'S60', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ولوو'), N'S90', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ولوو'), N'XC60', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ولوو'), N'XC90', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ولوو'), N'FH', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'ولوو'), N'FM', N'heavy_vehicle'),

((SELECT brand_id FROM Brand WHERE name=N'اسکانیا'), N'سری R', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'اسکانیا'), N'سری G', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'اسکانیا'), N'سری P', N'heavy_vehicle'),

((SELECT brand_id FROM Brand WHERE name=N'ساب'), N'۹-۳', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ساب'), N'۹-۵', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'کونیگ‌زیگ'), N'جسکو', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'کونیگ‌زیگ'), N'ریگرا', N'car'),

-- ==================== سایر کشورها ====================
((SELECT brand_id FROM Brand WHERE name=N'داچیا'), N'لوگان', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'داچیا'), N'ساندرو', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'داچیا'), N'داستر', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'اشکودا'), N'اکتاویا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'اشکودا'), N'سوپرب', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'اشکودا'), N'کروک', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'اشکودا'), N'کودیک', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'سیات'), N'لئون', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'سیات'), N'ایبیزا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'سیات'), N'تاراکو', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'تاترا'), N'فونیکس', N'heavy_vehicle'),

-- ==================== روسیه ====================
((SELECT brand_id FROM Brand WHERE name=N'لادا'), N'سامارا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لادا'), N'نیوا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لادا'), N'وستا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'لادا'), N'گرانتا', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'یوآز'), N'باکهانکا', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'یوآز'), N'هانتر', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'گاز'), N'گازل', N'heavy_vehicle'),

((SELECT brand_id FROM Brand WHERE name=N'کاماز'), N'۵۴۹۰', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'کاماز'), N'۶۵۲۰', N'heavy_vehicle'),

-- ==================== هند ====================
((SELECT brand_id FROM Brand WHERE name=N'تاتا'), N'سافاری', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'تاتا'), N'تیاگو', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'تاتا'), N'پرایما', N'heavy_vehicle'),

((SELECT brand_id FROM Brand WHERE name=N'ماهیندرا'), N'اسکورپیو', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ماهیندرا'), N'اکس‌یو‌وی ۷۰۰', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'ماروتی'), N'سویفت', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'ماروتی'), N'بالنو', N'car'),

-- ==================== مالزی / استرالیا / ترکیه / هلند ====================
((SELECT brand_id FROM Brand WHERE name=N'پروتون'), N'ساگا', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'پروتون'), N'پرسونا', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'پرودوآ'), N'مایوی', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'پرودوآ'), N'آکسیا', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'هولدن'), N'کومودور', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'هولدن'), N'یوت', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'توگ'), N'T10X', N'car'),
((SELECT brand_id FROM Brand WHERE name=N'توگ'), N'T8X', N'car'),

((SELECT brand_id FROM Brand WHERE name=N'داف'), N'XF', N'heavy_vehicle'),
((SELECT brand_id FROM Brand WHERE name=N'داف'), N'CF', N'heavy_vehicle'),

-- ------ هوندا (موجود) ------
((SELECT brand_id FROM Brand WHERE name=N'هوندا'), N'سی‌بی‌آر ۲۵۰آرآر', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'هوندا'), N'سی‌بی ۴۰۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'هوندا'), N'سی‌آر‌اف ۲۵۰ ال', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'هوندا'), N'ایکس-ادوی ۷۵۰', N'motorcycle'),

-- ------ سوزوکی (موجود) ------
((SELECT brand_id FROM Brand WHERE name=N'سوزوکی'), N'وی-استروم ۲۵۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'سوزوکی'), N'کاتانا', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'سوزوکی'), N'جی‌اس‌اس-۱۰۰۰', N'motorcycle'),

-- ------ بی‌ام‌و (موجود) ------
((SELECT brand_id FROM Brand WHERE name=N'BMW'), N'اس ۱۰۰۰ ایکس‌آر', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'BMW'), N'آر ۱۲۵۰ آر‌تی', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'BMW'), N'کی ۱۶۰۰ جی‌تی', N'motorcycle'),

-- ------ تریومف (موجود) ------
((SELECT brand_id FROM Brand WHERE name=N'تریومف'), N'بونویل', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'تریومف'), N'استریت تریپل', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'تریومف'), N'تایگر ۹۰۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'تریومف'), N'راکت ۳', N'motorcycle'),

-- ------ یاماها ------
((SELECT brand_id FROM Brand WHERE name=N'یاماها'), N'ام‌تی-۰۷', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'یاماها'), N'ام‌تی-۰۹', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'یاماها'), N'وای‌زد‌اف-آر۱', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'یاماها'), N'وای‌زد‌اف-آر۶', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'یاماها'), N'وای‌زد‌اف-آر۱۵', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'یاماها'), N'ان‌مکس ۱۵۵', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'یاماها'), N'تنره ۷۰۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'یاماها'), N'وای‌زد‌اف-آر۳', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'یاماها'), N'ام‌تی-۰۳', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'یاماها'), N'ایکس‌مکس ۳۰۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'یاماها'), N'ترسر ۹ جی‌تی', N'motorcycle'),

-- ------ دوکاتی ------
((SELECT brand_id FROM Brand WHERE name=N'دوکاتی'), N'مانستر', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'دوکاتی'), N'پانیگاله وی۴', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'دوکاتی'), N'استریت‌فایتر وی۴', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'دوکاتی'), N'مولتی‌استرادا وی۴', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'دوکاتی'), N'اسکرامبلر', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'دوکاتی'), N'دیاول وی۴', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'دوکاتی'), N'هایپرموتارد ۹۵۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'دوکاتی'), N'سوپراسپورت ۹۵۰', N'motorcycle'),

-- ------ هارلی-دیویدسون ------
((SELECT brand_id FROM Brand WHERE name=N'هارلی-دیویدسون'), N'استریت گلاید', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'هارلی-دیویدسون'), N'رود کینگ', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'هارلی-دیویدسون'), N'اسپورت‌استر اس', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'هارلی-دیویدسون'), N'فت بوی', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'هارلی-دیویدسون'), N'پن آمریکا', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'هارلی-دیویدسون'), N'هریتیج کلاسیک', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'هارلی-دیویدسون'), N'آیرن ۸۸۳', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'هارلی-دیویدسون'), N'رود گلاید', N'motorcycle'),

-- ------ کی‌تی‌ام ------
((SELECT brand_id FROM Brand WHERE name=N'کی‌تی‌ام'), N'دوک ۳۹۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'کی‌تی‌ام'), N'دوک ۸۹۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'کی‌تی‌ام'), N'سوپر دوک ۱۲۹۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'کی‌تی‌ام'), N'ادونچر ۷۹۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'کی‌تی‌ام'), N'ادونچر ۱۲۹۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'کی‌تی‌ام'), N'آر‌سی ۳۹۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'کی‌تی‌ام'), N'۳۹۰ ادونچر', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'کی‌تی‌ام'), N'۸۹۰ ادونچر', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'کی‌تی‌ام'), N'آر‌سی ۲۰۰', N'motorcycle'),

-- ------ آپریلیا ------
((SELECT brand_id FROM Brand WHERE name=N'آپریلیا'), N'آر‌اس‌وی۴', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'آپریلیا'), N'تئونو ۶۶۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'آپریلیا'), N'آر‌اس ۶۶۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'آپریلیا'), N'آر‌اس ۱۲۵', N'motorcycle'),

-- ------ موتو گوتزی ------
((SELECT brand_id FROM Brand WHERE name=N'موتو گوتزی'), N'وی۷', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'موتو گوتزی'), N'وی۸۵ تی‌تی', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'موتو گوتزی'), N'وی۱۰۰ ماندلو', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'موتو گوتزی'), N'وی۹', N'motorcycle'),

-- ------ بنلی ------
((SELECT brand_id FROM Brand WHERE name=N'بنلی'), N'تی‌آر‌کی ۵۰۲', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'بنلی'), N'لئونچینو ۵۰۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'بنلی'), N'تی‌آر‌کی ۷۰۲', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'بنلی'), N'لئونچینو ۸۰۰', N'motorcycle'),

-- ------ ام‌وی آگوستا ------
((SELECT brand_id FROM Brand WHERE name=N'ام‌وی آگوستا'), N'بروتاله', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'ام‌وی آگوستا'), N'توریسمو ولوسه', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'ام‌وی آگوستا'), N'سوپرولوسه', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'ام‌وی آگوستا'), N'بروتاله ۱۰۰۰', N'motorcycle'),

-- ------ رویال انفیلد ------
((SELECT brand_id FROM Brand WHERE name=N'رویال انفیلد'), N'کلاسیک ۳۵۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'رویال انفیلد'), N'کانتیننتال جی‌تی ۶۵۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'رویال انفیلد'), N'هیمالین ۴۱۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'رویال انفیلد'), N'متیور ۳۵۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'رویال انفیلد'), N'هانتر ۳۵۰', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'رویال انفیلد'), N'اینترسپتور ۶۵۰', N'motorcycle'),

-- ------ نورتون ------
((SELECT brand_id FROM Brand WHERE name=N'نورتون'), N'کوماندو ۹۶۱', N'motorcycle'),
((SELECT brand_id FROM Brand WHERE name=N'نورتون'), N'وی۴ اس‌وی', N'motorcycle');

GO