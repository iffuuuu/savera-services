$ErrorActionPreference = 'Stop'
$rs = [string][char]0x20B9

# ---------------------------------------------------------------
# AREA DATA (20 Pune areas) - nearby landmarks/societies/roads/schools/hospitals/IT parks/markets
# ---------------------------------------------------------------
$areas = @(
  @{ Name='Baner'; File='Baner'; Nearby=@('Baner Road','Balewadi High Street','Seasons Mall','Baner-Pashan Link Road','SIMS Hospital','Baner Gaon','Sinhgad Institute','Baner Market') },
  @{ Name='Balewadi'; File='Balewadi'; Nearby=@('Balewadi High Street','Shiv Chhatrapati Sports Complex','Smash Court','Mhalunge Road','Bhusari Colony','Datta Mandir Road','Balewadi Phata','Savitribai Phule University') },
  @{ Name='Wakad'; File='Wakad'; Nearby=@('Wakad Bridge','Datta Mandir Road','Jagtap Dairy','Wipro Circle','Xenia Complex','Tata Motors','Sanskruti Society','Kalpataru') },
  @{ Name='Pimple Saudagar'; File='Pimple-Saudagar'; Nearby=@('Pimple Saudagar Bus Stand','Rainbow Plaza','Vishal Mega Mart','Pimple Gurav','New Sangvi','Kalewadi Phata','Pimple Nilakh','Sai Chowk') },
  @{ Name='Aundh'; File='Aundh'; Nearby=@('Aundh ITI Road','Parihar Chowk','Aundh Bazar','Brahma Aundh','Aundh Hospital','Bremen','Aundh Police Station','Japan Travels') },
  @{ Name='Kothrud'; File='Kothrud'; Nearby=@('Paud Road','Karve Road','Mayur Colony','Kothrud Depot','Vanaz Corner','Dahanukar Colony','SNDT College','Ganesh Kala Krida') },
  @{ Name='Warje'; File='Warje'; Nearby=@('Warje Malwadi','Nanded Phata','Sinhagad Road','Warje Jakat Naka','Galaxy Society','Jijamata Balak Mandir','Ambegaon Khurd','Warje Market') },
  @{ Name='Karve Nagar'; File='Karve-Nagar'; Nearby=@('Karve Nagar Bus Stand','Hingane Khurd','Gujrawadi','Erandwane','Vanaz Corner','Nal Stop','Paud Phata','Dandekar Bridge') },
  @{ Name='Shivaji Nagar'; File='Shivaji-Nagar'; Nearby=@('Shivajinagar Court','SNDT College','Juna Bazaar','Vasant Nagar','Pune University','Ganeshkhind Road','FC Road','Khadki Bazaar') },
  @{ Name='Camp'; File='Camp'; Nearby=@('MG Road','East Street','South Main Road','Poona Club','Sassoon Hospital','Nehru Road','Arthur Road','Camp Market') },
  @{ Name='Kharadi'; File='Kharadi'; Nearby=@('Kharadi Bypass','EON IT Park','World Trade Center','Zensar','Kumar City','Ashok Nagar','Keshav Nagar','Chandan Nagar') },
  @{ Name='Viman Nagar'; File='Viman-Nagar'; Nearby=@('Viman Nagar Road','Phoenix Marketcity','Four Seasons Mall','D-Mart','Agakhan Palace','Viman Nagar Bus Stand','Kharadi Bypass','Nagar Road') },
  @{ Name='Magarpatta'; File='Magarpatta'; Nearby=@('Magarpatta City','Magarpatta SEZ','Amanora Park Town','Kharadi Bypass','Hadapsar','Mundhwa','Pune Railway Station','The Mills') },
  @{ Name='Mundhwa'; File='Mundhwa'; Nearby=@('Mundhwa Bridge','Koregaon Park','Manjri Road','Kesnand','Ramwadi','Viman Nagar','The Mills','Hadapsar') },
  @{ Name='Kondhwa'; File='Kondhwa'; Nearby=@('Kondhwa Khurd','NIBM Road','Undri','Mohammadwadi','Bibwewadi','Salunke Vihar','Kondhwa Budruk','Sinhagad Road') },
  @{ Name='Bibwewadi'; File='Bibwewadi'; Nearby=@('Bibwewadi Market','Salunke Vihar','Katraj','Dhankawadi','PICT College','Kondhwa Road','Bibwewadi Phase 1','Bibwewadi Phase 2') },
  @{ Name='Dhankawadi'; File='Dhankawadi'; Nearby=@('Dhankawadi Circle','PICT College','Bharti Vidyapeeth','Katraj','Sahakar Nagar','Padmavati','Ambegaon','Dhankawadi Market') },
  @{ Name='Sinhagad Road'; File='Sinhagad-Road'; Nearby=@('Sinhagad Road','Vadgaon Budruk','Narhe','Ambegaon','Gokhale Nagar','Sinhagad College','Khind','Amrutanjan Point') },
  @{ Name='Pimpri'; File='Pimpri'; Nearby=@('Pimpri Chowk','Nashik Phata','PCMC','Chapekar Chowk','Sant Tukaram Nagar','Bhosari','Kasarwadi','Pimpri Market') },
  @{ Name='Chinchwad'; File='Chinchwad'; Nearby=@('Chinchwad Gaon','Morwadi','Pradhikaran','Nigdi','Akurdi','Ravet','Kasarwadi','Thermax Chowk') }
)

# ---------------------------------------------------------------
# SERVICE CONFIGS
# ---------------------------------------------------------------
$serviceConfigs = @(
  @{
    Key='AC'; Folder='AC Page'; Prefix='AC-Repair-in-'; Css='AC For.css'
    HeroImg='../../images/AC/ac-repair.jpg'; HeroAlt='AC technician repairing a split AC at a home in {AREA} Pune'
    Icon1='../../images/AC/AC Servicing Near me.png'; Icon2='../../images/AC/AC.png'; Icon3='../../images/AC/AC Gas repair near me.png'; Icon4='../../images/AC/AC Installtion near me.png'; Icon5='../../images/AC/AC Not Cooling near me.png'
    CheckoutImg='../../images/AC/ac repair.jfif'
    ServiceRows=@(
      @{Img='../../images/AC/AC Gas repair near me.png'; Name='Split AC'; Price='499'; OPrice='799'; Id='Door Issue'},
      @{Img='../../images/AC/cassette ac Servicing 1.png'; Name='Cassette AC'; Price='699'; OPrice='799'; Id='Door Issue'},
      @{Img='../../images/AC/foam servicing.jpg'; Name='Foam Jet Service'; Price='599'; OPrice='799'; Id='Door Issue'},
      @{Img='../../images/AC/Window AC Servicing repair Near me.png'; Name='Window AC'; Price='599'; OPrice='799'; Id='Door Issue'},
      @{Img='../../images/AC/tower ac repair near me.jpg'; Name='Tower AC'; Price='599'; OPrice='799'; Id='Door Issue'}
    )
  },
  @{
    Key='Fridge'; Folder='Fridge Page'; Prefix='Fridge-Repair-in-'; Css='Fridge For.css'
    HeroImg='../../images/fridge/fridge-repair1.jpg'; HeroAlt='Technician servicing a refrigerator at a home in {AREA} Pune'
    Icon1='../../images/fridge/Fridge repair services near me.png'; Icon2='../../images/fridge/leakage.jpg'; Icon3='../../images/fridge/servicing.png'; Icon4='../../images/fridge/Door Issue fridge repair in pune .png'; Icon5='../../images/fridge/Light Issue fridge repair near me home service.png'
    CheckoutImg='../../images/fridge/fridge-repair1.jpg'
    ServiceRows=@(
      @{Img='../../images/fridge/sigel door fridge repair near me.jpg'; Name='Single Door'; Price='249'; OPrice='399'; Id=''},
      @{Img='../../images/fridge/Fridge repair services near me.png'; Name='Double Door'; Price='249'; OPrice='399'; Id=''},
      @{Img='../../images/fridge/tripel door fridge repair services in pune.png'; Name='Triple Door'; Price='249'; OPrice='399'; Id=''},
      @{Img='../../images/fridge/side by side  fridge repair in pune .png'; Name='Side by Side'; Price='249'; OPrice='399'; Id=''},
      @{Img='../../images/fridge/AMC Servicing fridge repair near me.png'; Name='Other'; Price='249'; OPrice='399'; Id=''}
    )
  },
  @{
    Key='Microwave'; Folder='Microwave Page'; Prefix='Microwave-Repair-in-'; Css='Microwave For.css'
    HeroImg='../../images/microvev/microvawe.jpg'; HeroAlt='Microwave oven repair expert at a home in {AREA} Pune'
    Icon1='../../images/microvev/Microwave.png'; Icon2='../../images/microvev/Microwave.png'; Icon3='../../images/microvev/Microwave.png'; Icon4='../../images/microvev/Microwave.png'; Icon5='../../images/microvev/Microwave.png'
    CheckoutImg='../../images/microvev/Microwave.png'
    ServiceRows=@(
      @{Img='../../images/microvev/Microwave.png'; Name='Microwave Repair'; Price='249'; OPrice='399'; Id=''},
      @{Img='../../images/microvev/repaar.jpg'; Name='Microwave Service'; Price='499'; OPrice='699'; Id=''}
    )
  },
  @{
    Key='TV'; Folder='TV Page'; Prefix='TV-Repair-in-'; Css='TV For.css'
    HeroImg='../../images/TV/istockphoto-1389783400-612x612.jpg'; HeroAlt='TV repair technician fixing a LED screen in {AREA} Pune'
    Icon1='../../images/tv/tv.png'; Icon2='../../images/TV/uninstall.jpg'; Icon3='../../images/tv/tv.png'; Icon4='../../images/tv/tv.png'; Icon5='../../images/tv/tv.png'
    CheckoutImg='../../images/tv/display.jpg'
    ServiceRows=@(
      @{Img='../../images/tv/tv.png'; Name='TV Repair'; Price='249'; OPrice='399'; Id=''},
      @{Img='../../images/TV/istockphoto-1389783400-612x612.jpg'; Name='TV Voice Problem'; Price='249'; OPrice='399'; Id='Installation'},
      @{Img='../../images/tv/uninstall.jpg'; Name='TV Installation'; Price='399'; OPrice='999'; Id=''},
      @{Img='../../images/tv/install.jpg'; Name='TV Uninstallation'; Price='349'; OPrice='999'; Id='CoolingIssue'}
    )
  },
  @{
    Key='Washing Machine'; Folder='Washing Machine Page'; Prefix='Washing-Machine-Repair-in-'; Css='Washing Machine For.css'
    HeroImg='../../images/washing machine/main image.jpg'; HeroAlt='Washing machine repair expert at a home in {AREA} Pune'
    Icon1='../../images/washing machine/Washing Machine.png'; Icon2='../../images/washing machine/double rb.png'; Icon3='../../images/washing machine/unistall rb.png'; Icon4='../../images/washing machine/Washing Machine.png'; Icon5='../../images/washing machine/Washing Machine.png'
    CheckoutImg='../../images/washing machine/main image.jpg'
    ServiceRows=@(
      @{Img='../../images/washing machine/Washing Machine.png'; Name='Front Load'; Price='249'; OPrice='399'; Id=''},
      @{Img='../../images/washing machine/top rb.png'; Name='Top Load'; Price='249'; OPrice='399'; Id=''},
      @{Img='../../images/washing machine/double rb.png'; Name='Semi Automatic'; Price='249'; OPrice='399'; Id='Service'},
      @{Img='../../images/washing machine/unistall rb.png'; Name='Other'; Price='249'; OPrice='399'; Id=''}
    )
  }
)

# ---------------------------------------------------------------
# SERVICE-SPECIFIC CONTENT (unique per service, area-tokenized)
# ---------------------------------------------------------------
function Get-ServiceContent {
  param($Key)
  $c = @{}
  if ($Key -eq 'AC') {
    $c.ServiceName = 'AC Repair'
    $c.PageTitle = 'AC Repair in {AREA} | Savera Services – Same-Day Service'
    $c.MetaDesc = 'AC repair in {AREA} Pune by Savera Services. Expert split & window AC service near {L1} with gas refilling, installation & warranty. Book today!'
    $c.H1 = 'AC Repair in {AREA} – Trusted Technicians at Your Door'
    $c.Hero = 'When Pune temperatures climb, a struggling air conditioner makes every room unbearable. Savera Services brings professional AC repair to {AREA}, covering apartments and offices near {L1}, {L2} and {L3}. Our certified technicians handle gas refilling, compressor faults, water leakage, and PCB issues using genuine spares with a 30-day warranty. We arrive with the right tools, diagnose the real problem, and give you an honest estimate before any work begins. Same-day slots, transparent pricing, and clean workmanship make us the go-to choice for AC service across {AREA} and the surrounding neighbourhoods.'
    $c.Intro = 'From split and window units to inverter and cassette models, our {AREA} team repairs every AC brand with speed and precision. Regular servicing keeps your unit cooling efficiently and lowers your electricity bill.'
    $c.OffersTitle = 'Exclusive Offers on AC Repair in {AREA}'
    $c.WhiteHeading = 'Why Families in {AREA} Choose Savera Services for AC Repair'
    $c.WhiteP1 = 'A faulty AC disrupts your comfort and your routine. Our technicians combine professional diagnosis, genuine branded spares, and honest pricing to get your cooling back quickly. We serve compact flats and large offices across {AREA}, {L1} and {L2} with the same care.'
    $c.WhiteP2 = 'Every job ends with a full performance test, a clean workspace, and a 30-day service warranty. That is why residents near {L3} recommend Savera Services to their neighbours.'
    $c.WhyChoose = 'A well-maintained air conditioner lasts longer and costs less to run. Savera Services connects you with verified AC experts in {AREA} who arrive on time and work cleanly. We provide split AC repair, window AC installation, gas charging, cooling and compressor repair, PCB fixes, and annual maintenance across {AREA}, {L1}, {L2} and {L3}.'
    $c.Closing = 'Facing an AC emergency in {AREA}? Call Savera Services now. We serve {L1}, {L2}, {L3} and the entire {AREA} belt with same-day appointments, experienced technicians, genuine spares, and a 30-day warranty on every job.'
    $c.CTA = 'Call {AREA} AC Technician'
    $c.Faqs = @(
      'Do you provide same-day AC repair in {AREA}?|Yes. We dispatch technicians across {AREA}, {L1} and {L2} on the same day. You receive a call within 30 minutes of booking.',
      'Which AC brands do you service in {AREA}?|We repair LG, Samsung, Voltas, Daikin, Blue Star, Hitachi, Carrier, Panasonic, Lloyd and more with genuine spares.',
      'Why is my AC running but not cooling?|Common causes are a dirty condenser coil, clogged air filter, or low refrigerant gas. We check all three during every {AREA} service visit.',
      'How much does AC repair cost in {AREA}?|Inspection starts at {rs}249. Standard repairs like capacitor or sensor replacement are typically {rs}800-{rs}1,800. Compressor or PCB jobs are quoted after diagnosis.',
      'What should I do if my AC is leaking water?|Switch off the unit and call us. Leaks are usually caused by a blocked drain pipe, dirty filter, or faulty condensate pump. We fix the cause to protect your home.',
      'Do you provide AC gas refilling near {L1}?|Absolutely. We offer gas top-up and full charging with a leak test first, so your new gas does not escape again.',
      'Can you install a new AC in my flat in {AREA}?|Yes. We install split, window and inverter ACs with proper copper piping, drainage routing, and electrical connections.',
      'Do you offer a warranty on AC repairs?|Every repair carries a 30-day service warranty. Replaced spare parts come with their own manufacturer-backed warranty.',
      'Is AC servicing necessary every year?|Yes. Dust and humidity reduce airflow and cooling efficiency over time. Annual pre-summer servicing prevents mid-season breakdowns.',
      'How fast can you reach my home in {AREA}?|Most same-day visits are completed within hours. Coverage includes {L1}, {L2} and {L3} plus the full {AREA} area.'
    )
    $c.Tips = @(
      'Wash AC filters every 2-4 weeks during peak summer for better airflow and cooling.',
      'Keep the outdoor unit clear of dust, leaves and obstructions to help the compressor breathe.',
      'Run the AC in dry mode during the monsoon to control indoor humidity and reduce load.',
      'Book a professional service before summer begins so your unit is ready for peak heat.',
      'Use a voltage stabilizer to protect your AC from power surges during storms.',
      'Keep curtains drawn during the hottest hours to reduce the cooling load on your AC.'
    )
    $c.Problems = @('AC not cooling or weak airflow','Water leakage and condensation','Unusual noises from the unit','AC tripping the MCB or not starting','Refrigerant gas leak','Frozen evaporator coil','Compressor or fan motor failure')
    $c.ProcessSteps = @('Book AC service online or by phone','Technician arrives with a full tool kit','Complete inspection including gas level','Transparent estimate - you approve first','Repair with genuine spare parts','Performance test and warranty activation')
    $c.ParaTitle = 'Why Regular AC Care Matters in {AREA}'
    $c.ParaBody = 'Air conditioners in {AREA} work hardest between March and June. Units that skip annual maintenance lose cooling capacity, consume more electricity, and fail at the worst moment. A simple pre-summer service - coil cleaning, filter washing, drain clearing, and a gas check - keeps your family comfortable and your bills predictable.'
    $c.ParaList = 'Split AC repair in {AREA}<br>Window AC installation and uninstallation<br>AC gas leak detection and refilling<br>Compressor, PCB and fan motor repair<br>AC shifting and reinstallation<br>Annual maintenance contracts<br>Cassette, tower and ductable AC servicing'
    $c.SeoServices = @('Split AC repair in {AREA}','Window AC repair in {AREA}','Inverter AC service in {AREA}','AC gas filling and recharging','AC cooling problem fixing','AC compressor repair and replacement','AC PCB board repair','Water leakage repair in AC units','AC installation and uninstallation')
    $c.Brands = @('LG AC Repair in {AREA}','Samsung AC Repair in {AREA}','Voltas AC Repair in {AREA}','Daikin AC Repair in {AREA}','Blue Star AC Repair in {AREA}','Hitachi AC Repair in {AREA}','Whirlpool AC Repair in {AREA}','Panasonic AC Repair in {AREA}')
    $c.ServiceList = @('AC Repair in {AREA}','AC Installation in {AREA}','AC Gas Filling in {AREA}','AC Shifting in {AREA}','AC PCB Repair & Replace in {AREA}','AC Fan Motor Repair in {AREA}','AC Compressor Repair in {AREA}')
  }
  elseif ($Key -eq 'Fridge') {
    $c.ServiceName = 'Fridge Repair'
    $c.PageTitle = 'Fridge Repair in {AREA} | Savera Services – Same-Day Service'
    $c.MetaDesc = 'Fridge repair in {AREA} Pune by Savera Services. Expert refrigerator service for single, double & side-by-side fridges near {L1} with gas charging & warranty.'
    $c.H1 = 'Fridge Repair in {AREA} – Fast, Honest & Doorstep Service'
    $c.Hero = 'A refrigerator that stops cooling puts your food and your budget at risk. Whether you live in a high-rise near {L1}, a row house close to {L2}, or an apartment beside {L3}, Savera Services brings professional fridge repair to {AREA} at your doorstep. Our experienced technicians diagnose compressor failure, gas leakage, thermostat faults, and door gasket wear using genuine spares backed by a 30-day warranty. We serve the complete {AREA} belt with same-day appointments and upfront pricing. When your fridge stops working, book Savera Services and protect your groceries and your peace of mind.'
    $c.Intro = 'From compact single-door units to large side-by-side refrigerators, our {AREA} team repairs every type and brand. We handle gas refilling, compressor replacement, PCB faults, defrost timer issues, and noisy operation with transparent estimates.'
    $c.OffersTitle = 'Exclusive Offers on Fridge Repair in {AREA}'
    $c.WhiteHeading = 'Trusted Refrigerator Repair Across {AREA}'
    $c.WhiteP1 = 'Your refrigerator works silently day and night, so when it fails you notice immediately. Savera Services treats every fridge repair in {AREA} with professional diagnosis, genuine branded parts, and a clean workspace. We service LG, Samsung, Whirlpool, Godrej, Haier and Bosch.'
    $c.WhiteP2 = 'From quick gas top-ups near {L1} to full compressor replacements around {L2}, our technicians carry common spares so most jobs finish in a single visit. Every repair is backed by a 30-day warranty.'
    $c.WhyChoose = 'A failing refrigerator affects daily life, so you deserve a team that arrives on time and fixes the problem correctly. Savera Services provides verified technicians, honest pricing, and genuine spare parts across {AREA}, {L1}, {L2} and {L3}. We handle not-cooling issues, water leakage, gas charging, compressor faults, and complete breakdowns.'
    $c.Closing = 'Need a reliable fridge technician in {AREA}? Call Savera Services now. We serve {L1}, {L2}, {L3} and the entire {AREA} belt with same-day appointments, genuine parts, and a 30-day warranty on every repair.'
    $c.CTA = 'Call {AREA} Fridge Technician'
    $c.Faqs = @(
      'Do you repair all fridge types in {AREA}?|Yes. We repair single-door, double-door, triple-door, side-by-side, inverter, and deep freezer units across {AREA}, {L1} and nearby areas.',
      'Which fridge brands do you service near {L1}?|We service LG, Samsung, Whirlpool, Godrej, Haier, Bosch, Panasonic, IFB and Hitachi with genuine spare parts.',
      'Why is my fridge not cooling but the light works?|This usually means the compressor is not running, the gas is low, or the defrost system has failed. We inspect all three and give you an honest diagnosis.',
      'How much does fridge gas refilling cost in {AREA}?|Gas refilling depends on the refrigerant type and quantity. We quote after a leak test so you never pay to recharge a leaking system.',
      'Do you provide a warranty on fridge repairs?|Yes. All repairs come with a 30-day service warranty, and replaced spare parts carry their own manufacturer warranty.',
      'Can you repair a side-by-side fridge near {L2}?|Absolutely. Our technicians are trained for large French-door and side-by-side refrigerators and carry specialised tools.',
      'Why is my fridge making a loud noise?|Noise usually comes from a worn fan motor, ice build-up, or a failing compressor. We diagnose the source and repair it before further damage.',
      'How often should I service my refrigerator?|We recommend professional servicing every 6-12 months, especially before summer, to keep coils clean and cooling efficient.',
      'Do you fix water leakage from the fridge?|Yes. Leaks are often caused by a blocked defrost drain or a worn gasket. We clear the drain and replace faulty seals.',
      'How quickly can you reach my home in {AREA}?|We confirm bookings within 30 minutes and complete most same-day visits within hours across {L1}, {L2} and {L3}.'
    )
    $c.Tips = @(
      'Clean the condenser coils at the back of your fridge every 6 months for better cooling.',
      'Never store hot food directly in the fridge - let it cool first to protect the compressor.',
      'Check the door gasket monthly by pressing a note against the closed door.',
      'Defrost manual models before ice builds up more than half an inch.',
      'Keep the fridge away from the oven and direct sunlight for efficient cooling.',
      'Book an annual professional service before summer to avoid mid-season breakdowns.'
    )
    $c.Problems = @('Refrigerator not cooling properly','Excess ice build-up or water pooling','Unusual noise or vibration','Fridge not turning on','Gas leakage and compressor failure','Door gasket damage','Thermostat and sensor faults')
    $c.ProcessSteps = @('Book fridge service online or by phone','Technician arrives with a full tool kit','Complete inspection and diagnosis','Transparent estimate - you approve first','Repair with genuine spare parts','Warranty activation and cleanup')
    $c.ParaTitle = 'Why Regular Fridge Care Matters in {AREA}'
    $c.ParaBody = 'Refrigerators in {AREA} run 24 hours a day, every day of the year. Dust, humidity and heavy usage reduce cooling efficiency and force the compressor to work harder. Regular servicing - coil cleaning, gasket inspection, temperature calibration, and drain clearing - keeps your food safe and your electricity bills low.'
    $c.ParaList = 'Fridge repair in {AREA}<br>Single and double door servicing<br>Side by side fridge repair<br>Gas refilling and leak detection<br>Compressor and thermostat replacement<br>Door gasket replacement<br>Deep freezer and mini fridge service'
    $c.SeoServices = @('Fridge not cooling repair in {AREA}','Water leakage repair in {AREA}','Fridge gas refilling in {AREA}','Compressor repair and replacement','Thermostat and sensor faults','PCB board and electrical repairs','Door gasket replacement and alignment')
    $c.Brands = @('LG Fridge Repair in {AREA}','Samsung Fridge Repair in {AREA}','Whirlpool Fridge Repair in {AREA}','Godrej Fridge Repair in {AREA}','Haier Fridge Repair in {AREA}','Bosch Fridge Repair in {AREA}','Panasonic Fridge Repair in {AREA}','IFB Fridge Repair in {AREA}')
    $c.ServiceList = @('Fridge Repair in {AREA}','Fridge Installation in {AREA}','Fridge Gas Filling in {AREA}','Fridge Shifting in {AREA}','Fridge PCB Repair in {AREA}','Fridge Fan Motor Repair in {AREA}','Fridge Compressor Repair in {AREA}')
  }
  elseif ($Key -eq 'Microwave') {
    $c.ServiceName = 'Microwave Repair'
    $c.PageTitle = 'Microwave Repair in {AREA} | Savera Services – Same-Day Service'
    $c.MetaDesc = 'Microwave oven repair in {AREA} Pune by Savera Services. Fast solo, grill & convection microwave service near {L1} with genuine parts & 30-day warranty.'
    $c.H1 = 'Microwave Repair in {AREA} – Quick & Professional Service'
    $c.Hero = 'A microwave that stops heating or starts sparking can disrupt your entire kitchen routine. Savera Services offers fast, professional microwave repair in {AREA}, covering homes near {L1}, {L2} and {L3}. Our technicians repair all brands - LG, Samsung, IFB, Whirlpool, Panasonic, Godrej and more - handling magnetron failure, turntable issues, door sensor faults, and control panel problems. We use genuine spare parts, provide a 30-day warranty, and finish most repairs in a single visit. Book Savera Services for reliable microwave repair across {AREA} with transparent pricing and same-day availability.'
    $c.Intro = 'Whether you own a solo, grill, convection, or built-in microwave, our {AREA} experts diagnose and fix heating issues, sparking, display faults, and button failures quickly at your doorstep.'
    $c.OffersTitle = 'Exclusive Offers on Microwave Repair in {AREA}'
    $c.WhiteHeading = 'Fast Microwave Oven Repair in {AREA}'
    $c.WhiteP1 = 'A broken microwave holds up your whole day. Savera Services specialises in fast microwave repair across {AREA}, {L1} and {L2}. Our technicians carry common spares like magnetrons, capacitors, and door switches, so most repairs are completed in one visit.'
    $c.WhiteP2 = 'We provide a 30-day warranty on every microwave repair and replaced part. Trust us near {L3} for honest pricing and quality workmanship.'
    $c.WhyChoose = 'Microwave ovens combine high voltage and heat, so repairs need trained hands. Savera Services sends verified technicians across {AREA}, {L1}, {L2} and {L3} who handle magnetron, transformer, diode, and control panel issues safely. Every job includes transparent pricing and a 30-day warranty.'
    $c.Closing = 'Microwave problems in {AREA}? Call Savera Services now. We provide same-day microwave repair across {L1}, {L2}, {L3} and all of {AREA} with genuine parts and warranty-backed work.'
    $c.CTA = 'Call {AREA} Microwave Technician'
    $c.Faqs = @(
      'Do you provide microwave repair in {AREA}?|Yes. We provide same-day microwave repair across {AREA}, {L1} and {L2} with trained technicians.',
      'Which microwave brands do you repair in {AREA}?|We repair LG, Samsung, IFB, Whirlpool, Panasonic, Godrej, Voltas, Electrolux and more.',
      'Why is my microwave not heating?|Common causes are a failed magnetron, faulty transformer, or capacitor issues. We diagnose the exact part and replace it with a genuine spare.',
      'What should I do if my microwave is sparking?|Stop using it immediately and unplug it. Sparking indicates arcing or a damaged waveguide. Book a professional inspection right away.',
      'How much does microwave repair cost in {AREA}?|Inspection starts at {rs}249. Final cost depends on the faulty part. We share the estimate before starting any repair.',
      'Can you fix the microwave turntable?|Yes. Turntable motors and coupling issues are common and are usually fixed in a single visit.',
      'Do you repair built-in microwaves near {L1}?|Yes. Our technicians handle solo, grill, convection, and built-in microwave models.',
      'Do you provide a warranty on microwave repairs?|Yes. Every microwave repair includes a 30-day service warranty on labour and replaced parts.',
      'How quickly can you reach my home in {AREA}?|We confirm bookings within 30 minutes, and same-day visits are available across {L2} and {L3}.',
      'Is it safe to keep using a microwave that makes noise?|Unusual noise may indicate a worn magnetron fan or high-voltage issue. Get it checked before further use.'
    )
    $c.Tips = @(
      'Clean the microwave interior regularly to prevent food build-up and maintain efficiency.',
      'Never use metal utensils or aluminium foil inside the microwave to avoid sparking.',
      'Do not run the microwave empty, as this can damage the magnetron.',
      'Check the door seals regularly to ensure safe and even heating.',
      'Use microwave-safe containers only to avoid melting and chemical release.',
      'Book an annual professional check-up to keep your microwave safe and efficient.'
    )
    $c.Problems = @('Microwave not heating food','Sparking or burning smell','Microwave shuts off suddenly','Turntable motor failure','Door latch and sensor issues','Display or control panel faults','Buttons or touchpad not responding')
    $c.ProcessSteps = @('Book microwave service online or by phone','Technician arrives with a full tool kit','Inspection and diagnosis of the fault','Transparent estimate - you approve first','Repair with genuine spare parts','Warranty activation and cleanup')
    $c.ParaTitle = 'Why Microwave Maintenance Matters in {AREA}'
    $c.ParaBody = 'Microwave ovens handle high voltage and high heat, so small faults can become safety hazards if ignored. Regular cleaning and timely repairs keep your microwave efficient and safe. Savera Services provides professional care for solo, grill, and convection models across {AREA}.'
    $c.ParaList = 'Microwave repair in {AREA}<br>Solo microwave service<br>Grill microwave repair<br>Convection microwave service<br>Built-in microwave repair<br>Heating issue and sparking fixes<br>Turntable and door sensor repair'
    $c.SeoServices = @('Microwave not heating repair in {AREA}','Sparking issue fixes in {AREA}','Turntable and motor repair','Door sensor and latch repair','Control panel and button fixes','Display issue repair','General microwave servicing in {AREA}')
    $c.Brands = @('LG Microwave Repair in {AREA}','Samsung Microwave Repair in {AREA}','IFB Microwave Repair in {AREA}','Whirlpool Microwave Repair in {AREA}','Panasonic Microwave Repair in {AREA}','Godrej Microwave Repair in {AREA}','Voltas Microwave Repair in {AREA}','Electrolux Microwave Repair in {AREA}')
    $c.ServiceList = @('Microwave Repair in {AREA}','Microwave Installation in {AREA}','Microwave Servicing in {AREA}','Microwave Magnetron Replacement in {AREA}','Microwave Door Sensor Repair in {AREA}','Microwave Turntable Repair in {AREA}','Microwave Control Panel Repair in {AREA}')
  }
  elseif ($Key -eq 'TV') {
    $c.ServiceName = 'TV Repair'
    $c.PageTitle = 'TV Repair in {AREA} | Savera Services – LED, LCD & Smart TV'
    $c.MetaDesc = 'TV repair in {AREA} Pune by Savera Services. Expert LED, LCD & Smart TV repair at home near {L1}. Backlight, panel & motherboard fixes with warranty.'
    $c.H1 = 'TV Repair in {AREA} – Clear Picture, Perfect Sound'
    $c.Hero = 'A blank screen or fuzzy display turns family movie night into a headache. Savera Services provides expert TV repair in {AREA}, covering homes and offices near {L1}, {L2} and {L3}. Our technicians fix no-picture issues, backlight failure, sound problems, motherboard faults, and smart TV software glitches for brands like Sony, Samsung, LG, Mi, OnePlus and Philips. We use genuine parts, offer a 30-day warranty, and complete most repairs on the spot. Book Savera Services for reliable TV repair across {AREA} with honest pricing and fast doorstep service.'
    $c.Intro = 'From LED and LCD to smart and plasma models, our {AREA} technicians diagnose screen, sound, and connectivity issues quickly and repair them with quality parts.'
    $c.OffersTitle = 'Exclusive Offers on TV Repair in {AREA}'
    $c.WhiteHeading = 'Reliable TV Repair Across {AREA}'
    $c.WhiteP1 = 'Your TV is your window to entertainment and news, so when it fails you want it fixed fast. Savera Services repairs all major TV brands across {AREA}, {L1} and {L2} - from backlight replacement to motherboard repair.'
    $c.WhiteP2 = 'We carry common spares and use anti-static tools for safe handling. Every repair is backed by a 30-day warranty, so you can relax near {L3} while we restore your screen.'
    $c.WhyChoose = 'TV panels are delicate, so repairs need experience and the right tools. Savera Services sends verified technicians across {AREA}, {L1}, {L2} and {L3} who handle screen, backlight, motherboard, and smart TV issues carefully. Every job includes transparent pricing and warranty-backed workmanship.'
    $c.Closing = 'TV trouble in {AREA}? Call Savera Services now. We provide same-day TV repair across {L1}, {L2}, {L3} and all of {AREA} with genuine parts and a 30-day warranty.'
    $c.CTA = 'Call {AREA} TV Technician'
    $c.Faqs = @(
      'Do you provide TV repair in {AREA}?|Yes. We provide fast TV repair and service across {AREA}, {L1} and {L2} with trained technicians.',
      'Which TV brands do you service in {AREA}?|We service Sony, Samsung, LG, Panasonic, Mi, OnePlus, Philips, Motorola, Vu and more.',
      'Why is my TV screen blank but the sound works?|This is usually a backlight or display panel issue. Our technicians can replace backlights or repair the panel as needed.',
      'Can a cracked TV screen be repaired?|Minor internal lines can be fixed, but physical cracks require panel replacement. We provide genuine parts with warranty.',
      'How much does TV repair cost in {AREA}?|Inspection starts at {rs}249. Specific repairs like panel, motherboard, or backlight are quoted after diagnosis.',
      'My smart TV apps are not loading - what should I do?|It may be due to outdated software or Wi-Fi issues. We handle firmware upgrades, Wi-Fi module repairs, and software fixes.',
      'Do you provide a warranty on TV repairs?|Yes. Every TV repair includes a 30-day service warranty on labour and replaced parts.',
      'Can you mount my TV on the wall in {AREA}?|Yes. We provide secure wall mounting, reinstallation, and alignment for all TV sizes.',
      'How quickly can you reach my home in {AREA}?|We confirm bookings within 30 minutes, and same-day visits are available across {L1} and {L2}.',
      'What causes lines or spots on the TV screen?|Lines often indicate panel or ribbon cable issues, while spots may be dead pixels. We diagnose and recommend the best fix.'
    )
    $c.Tips = @(
      'Keep your TV away from direct sunlight and moisture to protect the panel.',
      'Use a voltage stabilizer to guard against power surges and voltage fluctuations.',
      'Clean the screen with a soft microfiber cloth only - avoid harsh liquids.',
      'Update smart TV software regularly to keep apps and features working smoothly.',
      'Turn off the TV completely when not in use for long hours to save power.',
      'Ensure proper ventilation behind the TV to prevent overheating.'
    )
    $c.Problems = @('No picture or blank screen','No sound or distorted audio','TV not turning on','Backlight failure or flickering','Lines, spots, or cracks on panel','Smart TV apps and Wi-Fi issues','Remote and IR sensor faults')
    $c.ProcessSteps = @('Book TV service online or by phone','Technician arrives with a full tool kit','Inspection and diagnosis of the fault','Transparent estimate - you approve first','Repair with genuine spare parts','Warranty activation and cleanup')
    $c.ParaTitle = 'Why TV Care Matters in {AREA}'
    $c.ParaBody = 'Modern TVs are packed with delicate electronics that can be damaged by power surges, dust, and heat. Regular cleaning, firmware updates, and timely repairs extend the life of your screen and keep picture and sound quality at their best. Savera Services provides professional TV care across {AREA}.'
    $c.ParaList = 'TV repair in {AREA}<br>LED and LCD TV service<br>Smart TV repair<br>Backlight and panel replacement<br>Motherboard and power board repair<br>Sound and speaker fixes<br>Wall mounting and installation'
    $c.SeoServices = @('General TV service in {AREA}','Display issue repair - no picture, lines, spots','Backlight and panel replacement','Sound and speaker repair','Motherboard and power board repair','Smart TV software and Wi-Fi fixes','Wall mount and installation services')
    $c.Brands = @('Sony TV Repair in {AREA}','Samsung TV Repair in {AREA}','LG TV Repair in {AREA}','Panasonic TV Repair in {AREA}','Mi TV Repair in {AREA}','OnePlus TV Repair in {AREA}','Philips TV Repair in {AREA}','Vu TV Repair in {AREA}')
    $c.ServiceList = @('TV Repair in {AREA}','TV Installation in {AREA}','TV Screen Replacement in {AREA}','TV Backlight Repair in {AREA}','TV Motherboard Repair in {AREA}','TV Sound Problem Repair in {AREA}','Smart TV Software Update in {AREA}')
  }
  elseif ($Key -eq 'Washing Machine') {
    $c.ServiceName = 'Washing Machine Repair'
    $c.PageTitle = 'Washing Machine Repair in {AREA} | Savera Services – Same-Day Service'
    $c.MetaDesc = 'Washing machine repair in {AREA} Pune by Savera Services. Front load, top load & semi-automatic machine service near {L1} with genuine parts & warranty.'
    $c.H1 = 'Washing Machine Repair in {AREA} – Fast & Dependable Service'
    $c.Hero = 'A washing machine that stops spinning or leaks water turns laundry day into a chore. Savera Services provides expert washing machine repair in {AREA}, covering homes near {L1}, {L2} and {L3}. Our technicians fix front load, top load, and semi-automatic machines for brands like LG, Samsung, Whirlpool, IFB, Bosch and Haier. We handle motor failure, drainage problems, drum noise, door lock faults, and PCB issues using genuine spares with a 30-day warranty. Same-day appointments, honest estimates, and clean workmanship make Savera Services the trusted choice across {AREA}.'
    $c.Intro = 'From fully automatic front loaders to simple semi-automatic units, our {AREA} team repairs every washing machine type. We fix spinning, draining, leakage, noise, and electrical problems quickly.'
    $c.OffersTitle = 'Exclusive Offers on Washing Machine Repair in {AREA}'
    $c.WhiteHeading = 'Reliable Washing Machine Repair Across {AREA}'
    $c.WhiteP1 = 'A broken washing machine disrupts your whole household routine. Savera Services repairs all major brands across {AREA}, {L1} and {L2} - from motor and pump issues to drum and PCB faults.'
    $c.WhiteP2 = 'Our technicians carry common spares so most repairs finish in a single visit. Every job is backed by a 30-day warranty, giving you peace of mind near {L3}.'
    $c.WhyChoose = 'Washing machines combine water, electricity, and moving parts, so repairs need skilled hands. Savera Services sends verified technicians across {AREA}, {L1}, {L2} and {L3} who handle motors, pumps, drums, and electronic controls safely. Every job includes transparent pricing and warranty-backed workmanship.'
    $c.Closing = 'Washing machine trouble in {AREA}? Call Savera Services now. We provide same-day repair across {L1}, {L2}, {L3} and all of {AREA} with genuine parts and a 30-day warranty.'
    $c.CTA = 'Call {AREA} Washing Machine Technician'
    $c.Faqs = @(
      'Do you provide washing machine repair in {AREA}?|Yes. We provide fast washing machine repair and service across {AREA}, {L1} and {L2} with trained technicians.',
      'Which washing machine brands do you service in {AREA}?|We service LG, Samsung, Whirlpool, IFB, Bosch, Haier, Godrej, Voltas and more.',
      'Why is my washing machine not spinning?|Common causes are a broken drive belt, faulty motor, or a worn drum bearing. We diagnose the exact issue and fix it.',
      'My washing machine is leaking water - what should I do?|Leaks usually come from damaged hoses, faulty seals, or clogged drains. We inspect and repair the cause to prevent further damage.',
      'How much does washing machine repair cost in {AREA}?|Inspection starts at {rs}249. Final cost depends on the faulty part. We share the estimate before starting any repair.',
      'Do you provide a warranty on washing machine repairs?|Yes. Every washing machine repair includes a 30-day service warranty on labour and replaced parts.',
      'Can you install a new washing machine in {AREA}?|Yes. We install front load, top load, and semi-automatic machines with proper connections.',
      'Why is my machine making a loud noise?|Noise often indicates worn bearings, a loose drum, or foreign objects stuck in the pump. We inspect and fix it quickly.',
      'How quickly can you reach my home in {AREA}?|We confirm bookings within 30 minutes, and same-day visits are available across {L1} and {L2}.',
      'Do you repair washing machine PCBs?|Yes. Our technicians repair or replace PCB boards and electronic controls for all major brands.'
    )
    $c.Tips = @(
      'Do not overload the drum - overloading strains the motor and bearings.',
      'Clean the detergent drawer and door seal regularly to prevent mould and odour.',
      'Leave the door open after a wash to let the drum dry and prevent mildew.',
      'Check pockets for coins and metal objects before loading clothes.',
      'Clean the lint filter and drain pump filter every few weeks.',
      'Use the right amount of detergent to avoid excess foam and residue build-up.'
    )
    $c.Problems = @('Machine not spinning or draining','Water leakage or overflow','Unusual noise or vibration','Power and wiring problems','Door lock and panel issues','Motor, pump, and drum repairs','Complete servicing and maintenance')
    $c.ProcessSteps = @('Book washing machine service online or by phone','Technician arrives with a full tool kit','Inspection and diagnosis of the fault','Transparent estimate - you approve first','Repair with genuine spare parts','Warranty activation and cleanup')
    $c.ParaTitle = 'Why Washing Machine Care Matters in {AREA}'
    $c.ParaBody = 'Washing machines run multiple times a week in most {AREA} homes, so wear and tear is inevitable. Detergent residue, lint, and hard water deposits reduce efficiency and cause breakdowns. Regular servicing - drum cleaning, drain checks, and motor inspection - keeps your machine running smoothly and your clothes fresh.'
    $c.ParaList = 'Washing machine repair in {AREA}<br>Front load repair and servicing<br>Top load repair and servicing<br>Semi-automatic machine service<br>Water leakage and drainage fixes<br>Motor and pump repair<br>Installation and uninstallation'
    $c.SeoServices = @('Front load washing machine repair in {AREA}','Top load washing machine repair in {AREA}','Semi-automatic machine repair in {AREA}','Water leakage repair in {AREA}','Drum noise and vibration fixes','Motor and pump repair','PCB and electrical fault repair')
    $c.Brands = @('LG Washing Machine Repair in {AREA}','Samsung Washing Machine Repair in {AREA}','Whirlpool Washing Machine Repair in {AREA}','IFB Washing Machine Repair in {AREA}','Bosch Washing Machine Repair in {AREA}','Haier Washing Machine Repair in {AREA}','Godrej Washing Machine Repair in {AREA}','Voltas Washing Machine Repair in {AREA}')
    $c.ServiceList = @('Washing Machine Repair in {AREA}','Washing Machine Installation in {AREA}','Washing Machine Uninstallation in {AREA}','Washing Machine Servicing in {AREA}','Washing Machine Shifting in {AREA}','Washing Machine PCB Repair in {AREA}','Washing Machine Motor Repair in {AREA}')
  }
  return $c
}

# ---------------------------------------------------------------
# PAGE BUILDER
# ---------------------------------------------------------------
function Build-Page {
  param($Area, $Service, $Index)
  $content = Get-ServiceContent -Key $Service.Key
  $areaName = $Area.Name
  $near = $Area.Nearby
  $L1 = $near[0]; $L2 = $near[1]; $L3 = $near[2]

  # Rotate FAQ selection: 8 of 10, offset by index
  $faqs = @()
  $n = $content.Faqs.Count
  for ($k = 0; $k -lt 8; $k++) {
    $faqs += $content.Faqs[($Index + $k) % $n]
  }
  # Rotate tips: 5 of 6
  $tips = @()
  $m = $content.Tips.Count
  for ($k = 0; $k -lt 5; $k++) {
    $tips += $content.Tips[($Index + $k) % $m]
  }

  # Replace tokens in a string
  function Fill($s) {
    return $s.Replace('{AREA}',$areaName).Replace('{L1}',$L1).Replace('{L2}',$L2).Replace('{L3}',$L3).Replace('{rs}',$rs)
  }

  # Build FAQ HTML
  $faqHtml = ''
  foreach ($f in $faqs) {
    $parts = $f -split '\|'
    $q = Fill $parts[0]; $a = Fill $parts[1]
    $faqHtml += @"
    <div class="accordion-item">
      <button class="accordion-title">
        <span class="arrow">▼</span>
        $q
      </button>
      <div class="accordion-content">
        <p>$a</p>
      </div>
    </div>

"@
  }

  # Build tips accordion HTML
  $tipHtml = ''
  foreach ($t in $tips) {
    $t2 = Fill $t
    $tipHtml += @"
    <div class="accordion-item">
      <button class="accordion-title">
        <span class="arrow">▼</span>
        $t2
      </button>
      <div class="accordion-content">
        <p>$t2 Regular professional care keeps your $($Service.Key.ToLower()) efficient and safe. Savera Services serves all of $areaName with expert technicians.</p>
      </div>
    </div>

"@
  }

  # Build tips list HTML for SEO section
  $tipsListHtml = ''
  foreach ($t in $tips) {
    $t2 = Fill $t
    $tipsListHtml += "      <li>$t2</li>`n"
  }

  # Build service rows
  $rowsHtml = ''
  $rowCount = $Service.ServiceRows.Count
  for ($i = 0; $i -lt $rowCount; $i++) {
    $row = $Service.ServiceRows[$i]
    $noLine = if ($i -eq $rowCount - 1) { ' no-line' } else { '' }
    $idAttr = ''
    if ($i -eq 1 -and $Service.Key -eq 'TV') { $idAttr = ' id="Installation"' }
    if ($i -eq 3 -and $Service.Key -eq 'TV') { $idAttr = ' id="CoolingIssue"' }
    $price = $rs + $row.Price
    $oprice = $rs + $row.OPrice
    $rowsHtml += @"
    <div class="service-row$noLine">
      <img src="$($row.Img)" alt="$($row.Name) $($Service.Key) repair in $areaName">
      <div class="service-info">
        <h3>$($row.Name)</h3>
        <div class="price"$idAttr>
          $price <span>$oprice</span>
        </div>
      </div>
      <button class="add-btn" onclick="openModal('$($row.Name)', '$price')">Add to Cart</button>
    </div>

"@
  }

  # Problems list
  $problemsHtml = ''
  foreach ($p in $content.Problems) { $problemsHtml += "      <li>" + (Fill $p) + "</li>`n" }

  # Seo services list
  $seoServicesHtml = ''
  foreach ($p in $content.SeoServices) { $seoServicesHtml += "      <li>" + (Fill $p) + "</li>`n" }

  # Brands list
  $brandsHtml = ''
  foreach ($p in $content.Brands) { $brandsHtml += "      <li>" + (Fill $p) + "</li>`n" }

  # Service list (general)
  $servListHtml = ''
  foreach ($p in $content.ServiceList) { $servListHtml += "      <li>" + (Fill $p) + "</li>`n" }

  # Nearby areas (all 20 area names for cross-linking footer SEO list)
  $allAreasHtml = ''
  foreach ($a in $areas) {
    if ($a.Name -ne $areaName) { $allAreasHtml += "      <li>$($a.Name)</li>`n" }
  }

  # Process steps
  $procHtml = ''
  foreach ($p in $content.ProcessSteps) {
    $procHtml += "      <li>" + (Fill $p) + "</li>`n"
  }

  # Build title / meta / canonical
  $title = Fill $content.PageTitle
  $metaDesc = Fill $content.MetaDesc
  $h1 = Fill $content.H1
  $hero = Fill $content.Hero
  $intro = Fill $content.Intro
  $offersTitle = Fill $content.OffersTitle
  $whiteHeading = Fill $content.WhiteHeading
  $whiteP1 = Fill $content.WhiteP1
  $whiteP2 = Fill $content.WhiteP2
  $whyChoose = Fill $content.WhyChoose
  $closing = Fill $content.Closing
  $cta = Fill $content.CTA
  $paraTitle = Fill $content.ParaTitle
  $paraBody = Fill $content.ParaBody
  $paraList = Fill $content.ParaList
  $heroAlt = Fill $Service.HeroAlt

  $slug = $Service.Prefix + $Area.File
  $canonical = "https://saveraservices.com/Area-Pages/" + $Service.Folder.Replace(' ','-') + "/" + $slug
  $ogImage = "https://saveraservices.com" + $Service.HeroImg.Replace('../../','/')

  $folderPath = Join-Path (Join-Path $PSScriptRoot 'Area Pages') $Service.Folder
  # Actually $PSScriptRoot = Area Pages folder where script resides
  $outPath = Join-Path $PSScriptRoot (Join-Path $Service.Folder ($slug + '.html'))

  $keywords = (($Service.Key.ToLower() + " repair in " + $areaName.ToLower()) + ", " + ($Service.Key.ToLower() + " service " + $areaName.ToLower()) + ", " + ($Service.Key.ToLower() + " repair near me " + $areaName.ToLower()))

  $page = @"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>$title</title>
  <meta name="description" content="$metaDesc">
  <meta name="keywords" content="$keywords">
  <meta name="robots" content="index, follow">
  <meta name="author" content="Savera Services">
  <link rel="canonical" href="$canonical" />
  <meta property="og:type" content="website" />
  <meta property="og:title" content="$title" />
  <meta property="og:description" content="$metaDesc" />
  <meta property="og:url" content="$canonical" />
  <meta property="og:image" content="$ogImage" />
  <meta property="og:site_name" content="Savera Services" />
  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:title" content="$title" />
  <meta name="twitter:description" content="$metaDesc" />
  <meta name="twitter:image" content="$ogImage" />
  <link rel="stylesheet" href="$($Service.Css)" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <link rel="icon" type="image/png" sizes="128x128" href="../../images/Favicon.png">
</head>
<body>

<nav class="navbar">
  <div class="nav-container">
    <div class="logo">
      <img src="../../images/Main Logo.png" alt="Savera Services Logo" class="logo-img">
    </div>
    <div class="menu-toggle" id="menu-toggle">
      <i class="fas fa-bars"></i>
    </div>
    <ul class="nav-links" id="nav-links">
      <li><a href="../../index.html"><i class="fas fa-home"></i> Home</a></li>
      <li><a href="../../AC-Repair-Pune.html"><i class="fas fa-city"></i> Pune</a></li>
    </ul>
  </div>
</nav>

<div class="hero-contact">
  <div class="contact-image">
    <img src="$($Service.HeroImg)" alt="$heroAlt" />
  </div>
  <div class="hero-content">
    <h1>$h1</h1>
    <p>
      $hero
    </p>
    <div class="hero-actions">
      <a href="tel:+917020991141" class="call-btn"><i class="fas fa-phone"></i>Call Now</a>
      <a href="https://wa.me/918793146415" target="_blank" class="whatsapp-btn"><i class="fab fa-whatsapp"></i> WhatsApp</a>
    </div>
  </div>
</div>

<section class="services">
  <div class="section-divider"></div>
  <h2 data-aos="fade-up">$($Service.Key) Services in $areaName</h2>
  <div class="icon-container">
    <a href="#Repair" class="service-icon" data-aos="fade-up">
      <img src="$($Service.Icon1)" alt="$($Service.Key) repair near $L1" class="custom-icon">
      <span>Repair</span>
    </a>
    <a href="#Repair" class="service-icon" data-aos="fade-up">
      <img src="$($Service.Icon2)" alt="$($Service.Key) servicing in $areaName" class="custom-icon">
      <span>Servicing</span>
    </a>
    <a href="#Repair" class="service-icon" data-aos="fade-up">
      <img src="$($Service.Icon3)" alt="$($Service.Key) installation near $L2" class="custom-icon">
      <span>Installation</span>
    </a>
    <a href="#Repair" class="service-icon" data-aos="fade-up">
      <img src="$($Service.Icon4)" alt="$($Service.Key) maintenance in $areaName" class="custom-icon">
      <span>Maintenance</span>
    </a>
    <a href="#Repair" class="service-icon" data-aos="fade-up">
      <img src="$($Service.Icon5)" alt="$($Service.Key) AMC package near $L3" class="custom-icon">
      <span>AMC</span>
    </a>
  </div>
</section>

<section class="service-page" id="Repair">
  <div class="services-list">
    <h1>$($Service.Key) Repair in $areaName</h1>
    <p class="desc">
      $intro
    </p>
$rowsHtml
  </div>

  <aside class="checkout-box">
    <img src="$($Service.CheckoutImg)" alt="Book $($Service.Key) service in $areaName online">
    <h3>Choose Services</h3>
    <button class="checkout-btn" onclick="openModal('$($Service.Key) Check Up')">Proceed to Checkout →</button>
    <p>
      If service is not repaired after inspection, $($rs)249 inspection charge applicable.
    </p>
  </aside>
</section>

<div class="two-box-layout">
  <div class="offer-wrapper">
    <h2 class="offer-title">
      $offersTitle
    </h2>
    <div class="offer-card">
      <img src="../../images/Service tag.png" alt="Best $($Service.Key) repair deals in $areaName">
      <div>
        <h4>Local pricing, real savings</h4>
        <p>Assured saving on every $($Service.Key) service order</p>
      </div>
    </div>
    <div class="offer-card">
      <img src="../../images/Discount tag.png" alt="First booking discount in $areaName">
      <div>
        <h4>5% off first booking</h4>
        <p>Flat discount on your first service in $areaName</p>
      </div>
    </div>
    <div class="offer-card">
      <img src="../../images/offer Tag.png" alt="Daily service offers in $areaName">
      <div>
        <h4>Offers refreshed daily</h4>
        <p>New deals every day across all services</p>
      </div>
    </div>
    <div class="offer-card">
      <img src="../../images/Peyment Tag.png" alt="Pay after service in $areaName">
      <div>
        <h4>Pay after service</h4>
        <p>Advance needed only if spare parts are required</p>
      </div>
    </div>
    <a href="tel:+917020991141"><button class="call-bttn">📞 $cta</button></a>
  </div>

  <div class="service-info white">
    <h2>$whiteHeading</h2>
    <p>$whiteP1</p>
    <p>$whiteP2</p>
    <p class="price">
      Service charges start from – <strong>$($rs)399/-</strong>
    </p>
    <h4>Repair services include:</h4>
    <ul>
      <li>$($Service.Key) Repair in $areaName</li>
      <li>Emergency same-day service</li>
      <li>Genuine spare parts</li>
      <li>30-day service warranty</li>
    </ul>
    <p class="note">
      <strong>Note:</strong> Repair prices may vary based on $($Service.Key.ToLower()) condition, brand, and distance from $areaName.
    </p>
  </div>
</div>

<div class="tips-faq-wrapper">
  <section class="faq-section">
    <h2>$($Service.Key) Maintenance Tips for $areaName Homes</h2>
    <div class="accordion">
$tipHtml    </div>
  </section>

  <section class="faq-section">
    <h2>$($Service.Key) in $areaName – FAQs</h2>
    <div class="accordion">
$faqHtml    </div>
  </section>
</div>

<div class="repair-left">
  <section class="description-container">
    <div class="description-left">
      <h3>Why Choose Savera Services in $areaName?</h3>
      <p>$whyChoose</p>
    </div>
    <div class="description-right">
      <div class="trusted-customers-badge">
        <div class="customer-count">499+</div>
        <p class="customer-text">Trusted Customers</p>
        <p class="customer-subtext">Happy with our service</p>
      </div>
    </div>
  </section>
</div>

<section class="seo-section">
  <div class="seo-container">
    <h2>$($Service.Key) & Service in $areaName – Savera Services</h2>
    <p>
      Savera Services is a locally trusted provider of $($Service.Key.ToLower()) services in $areaName, Pune. We serve homes, apartments, retail shops, and offices near $L1, $L2 and $L3. From a quick check-up to a complete repair, our technicians bring the right tools and genuine spares to your doorstep with transparent pricing.
    </p>

    <h3>Our Repair Process in $areaName</h3>
    <ol>
$procHtml    </ol>

    <h3>Common $($Service.Key) Problems We Fix in $areaName</h3>
    <ul>
$problemsHtml    </ul>

    <h3>Service Areas We Cover in $areaName</h3>
    <p>We provide $($Service.Key.ToLower()) services across $areaName and its nearby localities including:</p>
    <ul>
      <li>$L1</li>
      <li>$L2</li>
      <li>$L3</li>
      <li>All major residential & commercial areas of $areaName</li>
    </ul>

    <h2>Brand $($Service.Key) Services in $areaName</h2>
    <ul>
$brandsHtml    </ul>

    <h2>$($Service.Key) Services We Provide in $areaName</h2>
    <ul>
$servListHtml    </ul>

    <h3>$($Service.Key) Maintenance Tips for $areaName</h3>
    <ul>
$tipsListHtml    </ul>

    <h2>Related Services in $areaName</h2>
    <ul>
      <li><a href="../AC-Page/AC-Repair-in-$($Area.File).html">AC Repair in $areaName</a></li>
      <li><a href="../Fridge-Page/Fridge-Repair-in-$($Area.File).html">Fridge Repair in $areaName</a></li>
      <li><a href="../Microwave-Page/Microwave-Repair-in-$($Area.File).html">Microwave Repair in $areaName</a></li>
      <li><a href="../TV-Page/TV-Repair-in-$($Area.File).html">TV Repair in $areaName</a></li>
      <li><a href="../Washing-Machine-Page/Washing-Machine-Repair-in-$($Area.File).html">Washing Machine Repair in $areaName</a></li>
    </ul>

    <h2>Other Pune Areas We Serve</h2>
    <ul>
$allAreasHtml    </ul>

    <h2>Contact Savera Services for $($Service.Key) in $areaName</h2>
    <p>$closing</p>
  </div>
</section>

<div id="bookingModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal()">&times;</span>
    <h2 id="modalServiceName" style="color: #ffffff; font-size: 1.2rem; font-weight: 700; text-align:center;">Service Name</h2>
    <p class="modal-price" id="modalServicePrice" style="color: #000000; font-size: 1.2rem; text-align:center; font-weight:600;">Price</p>
    <form id="bookingForm">
      <input name="name" type="text" placeholder="Your Name" required />
      <input name="mobile" type="tel" placeholder="Mobile Number" required />
      <input name="address" type="text" placeholder="Address" required />
      <input id="serviceInput" name="service" type="hidden" />
      <input id="priceInput" name="price" type="hidden" />
      <button type="submit"><i class="fas fa-check-circle"></i> Confirm Booking</button>
      <div class="form-note" style="color:#fffefe; text-align:center; margin-top:12px;">
        <strong>Note:</strong><br>
        <p>This price is only the check-up price; we will confirm the final price after inspection.</p>
      </div>
      <div class="process-steps">
        <h3>Our Process</h3>
        <div class="step">
          <div class="circle">1</div>
          <div class="text">
            <strong>Inspection & quote</strong>
            <p>We inspect the appliance & share a repair quote for approval</p>
          </div>
        </div>
        <div class="step">
          <div class="circle">2</div>
          <div class="text">
            <strong>Approval or expert review</strong>
            <p>Repair begins after your approval, if you are unsure you can call our expert.</p>
          </div>
        </div>
        <div class="step">
          <div class="circle">3</div>
          <div class="text">
            <strong>Repair & spare parts</strong>
            <p>If needed, we will source spare parts at fixed rates for the repair</p>
          </div>
        </div>
        <div class="step">
          <div class="circle">4</div>
          <div class="text">
            <strong>Warranty activation</strong>
            <p>Our Company gives you 30 Days Warranty</p>
          </div>
        </div>
      </div>
      <div class="form-note" style="color:#fffefe; text-align:center; margin-top:12px;">
        <strong>Note:</strong>
        <br><p>Our technician will call you within 30 minutes to confirm your booking details.</p>
        <p>This price is only the check-up price; we will confirm the final price after inspection.</p>
        <p>Our Company gives you 30 Days Warranty.</p>
      </div>
    </form>
    <p class="success-message" id="successMessage">Thank you! Your booking is confirmed.</p>
  </div>
</div>

<div id="successTickModal" class="modal">
  <div class="modal-content tick-modal">
    <div class="big-tick">✔️</div>
    <p class="success-text">Booking Confirmed!</p>
  </div>
</div>

<script>
  document.getElementById("menu-toggle").addEventListener("click", function () {
    document.getElementById("nav-links").classList.toggle("active");
  });

  const scriptURL = 'https://script.google.com/macros/s/AKfycbwEfZiakd4otU2Aocj8o_fczm68SnwC4PavYYPJ9jSYDD3BU9kPnkK_pKgBOQNz8MaEyQ/exec';

  function openModal(service, price) {
    document.getElementById("bookingModal").style.display = "flex";
    document.getElementById("modalServiceName").innerText = service;
    document.getElementById("modalServicePrice").innerText = price;
    document.getElementById("serviceInput").value = service;
    document.getElementById("priceInput").value = price;
    document.getElementById("successMessage").style.display = "none";
  }

  function closeModal() {
    document.getElementById("bookingModal").style.display = "none";
  }

  document.getElementById("bookingForm").addEventListener("submit", function(e) {
    e.preventDefault();
    const form = new FormData(this);
    fetch(scriptURL, { method: 'POST', body: form })
      .then(() => {
        document.getElementById("successMessage").style.display = "none";
        document.getElementById("bookingModal").style.display = "none";
        const tickModal = document.getElementById("successTickModal");
        tickModal.style.display = "flex";
        setTimeout(() => {
          tickModal.style.display = "none";
        }, 1000);
        this.reset();
      })
      .catch(() => alert("Error! Try again."));
  });

  window.onclick = function(event) {
    if (event.target === document.getElementById("bookingModal")) {
      closeModal();
    }
  };
  const boxes = document.querySelectorAll('.two-box-layout > div');

  const observer = new IntersectionObserver(
    entries => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('show');
        }
      });
    },
    { threshold: 0.25 }
  );

  boxes.forEach(box => {
    observer.observe(box);
  });
  const serviceIcons = document.querySelectorAll('.service-icon');

  const iconObserver = new IntersectionObserver(
    entries => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('show');
        }
      });
    },
    { threshold: 0.2 }
  );

  serviceIcons.forEach(icon => {
    iconObserver.observe(icon);
  });

  const titles = document.querySelectorAll(".accordion-title");

  titles.forEach(title => {
    title.addEventListener("click", () => {
      titles.forEach(other => {
        if (other !== title) {
          other.classList.remove("active");
          other.nextElementSibling.style.maxHeight = null;
        }
      });
      title.classList.toggle("active");
      const content = title.nextElementSibling;
      if (content.style.maxHeight) {
        content.style.maxHeight = null;
      } else {
        content.style.maxHeight = content.scrollHeight + "px";
      }
    });
  });
  function toggleTip(currentBox) {
    const allBoxes = document.querySelectorAll('.tip-box');
    allBoxes.forEach(box => {
      if (box !== currentBox) {
        box.classList.remove('active');
        box.querySelector('.arrow').innerText = '▶';
      }
    });
    const arrow = currentBox.querySelector('.arrow');
    currentBox.classList.toggle('active');
    arrow.innerText = currentBox.classList.contains('active') ? '▼' : '▶';
  }
</script>
</body>
</html>
"@

  return $page
}

# ---------------------------------------------------------------
# GENERATE ALL PAGES
# ---------------------------------------------------------------
$count = 0
$index = 0
foreach ($area in $areas) {
  foreach ($svc in $serviceConfigs) {
    $html = Build-Page -Area $area -Service $svc -Index $index
    $folder = Join-Path $PSScriptRoot $svc.Folder
    if (-not (Test-Path $folder)) { New-Item -ItemType Directory -Path $folder -Force | Out-Null }
    $filename = $svc.Prefix + $area.File + '.html'
    $out = Join-Path $folder $filename
    [System.IO.File]::WriteAllText($out, $html, [System.Text.UTF8Encoding]::new($false))
    $count++
  }
  $index++
}
Write-Host "Generated $count pages successfully."


