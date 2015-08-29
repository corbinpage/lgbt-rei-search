require 'json'
require 'csv'
require 'capybara'
require 'capybara/dsl'

site_titles = ["ART Fertility Program of Alabama","Alabama Fertility Specialists","University of Alabama at Birmingham","Center for Reproductive Medicine","University of South Alabama","Arkansas Fertility Center","Troche Fertility Centers","Arizona Reproductive Medicine Specialists","Southwest Fertility Center","Advanced Fertility Care, PLLC","Arizona Associates for Reproductive Health","Boston IVF, The Arizona Center","IVF Phoenix","Fertility Treatment Center, PC","Arizona Center for Reproductive Endocrinology and Infertility","Reproductive Health Center","Vivere Arizona Reproductive Institute","Alta Bates IVF Program","Center for Reproductive Health and Gynecology","Southern California Reproductive Center","N/A Central California IVF Program","HRC Fertility - Encino","The Fertility Institutes-California, New York","California Center for Reproductive Medicine","Zouves Fertility Center","West Coast Fertility Centers","Kaiser Permanente Center for Reproductive Health","CARE Fertility","Coastal Fertility Medical Center","Fertility Center of Southern California","Reproductive Partners -UCSD","Acacio Fertility Center","Loma Linda University","USC Fertility","California Fertility Partners","Cedars-Sinai Medical Center","UCLA Fertility Center","Cha Fertility Center","Fertility and Gynecology Center","NOVA In Vitro Fertilization","HRC Fertility - Orange County","Newport Fertility Center","Reproductive Specialty Medical Center","Southern California Center for Reproductive Medicine","Lane Fertility Institute","Bay IVF Center","HRC Fertility - Pasadena","Palo Alto Medical Foundation","LA/OC Fertility, Inc.","Reproductive Partners - Beverly Hills, Redondo Beach & Westminster","Northern California Fertility Medical Center","Kaiser Permanente Center for Reproductive Health Sacramento","Reproductive Sciences Center","Fertility Specialists Medical Group","San Diego Fertility Center","Laurel Fertility Care","Pacific Fertility Center","UCSF Center for Reproductive Health","PAMF Fertility Physicians of Northern California","Alex Steinleitner, M.D., Inc","Reproductive Science Center","Santa Barbara Fertility Center","UCLA Fertility Center Santa Monica","Advanced Fertility Associates Medical Group Inc","The Valley Center for Reproductive Health","Garfield Fertility Center","Stanford University IVF/ART Program","Center for Fertility and Gynecology","Tree of Life Center","Fertility & Surgical Associates of California","Pacific Reproductive Center","Beverly Hills Reproductive Fertility","Reproductive Partners-Westminster","Reproductive Medicine and Fertility Center","Advanced Reproductive Medicine University of Colorado Hospital","Colorado Reproductive Endocrinology","Fertile Hope IVF","Rocky Mountain Center for Reprod. Med.","Conceptions Reproductive Associates","Colorado Ctr. for Reproductive Medicine","Rocky Mountain Fertility Center, P.C.","Connecticut Fertility Associates","The Center for Advanced Reproductive Services","Greenwich Fertility and IVF Center, P.C.","Yale University IVF Program","Reproductive Medicine Associates of Connecticut","Stamford Hospital","Park Avenue Fertility and Reproductive Medicine","Columbia Fertility Associates","George Washington University","James A. Simon, M.D., PC","Delaware Institute for Reproductive Medicine, PA","Reproductive Associates of Delaware","Boca Fertility","Palm Beach Fertility Center","Specialists in Reproductive Medicine and Surgery, P.A , Embryo Donation International","UF and Shands Reproductive Medicine at Spring Hill","Jacksonville Center for Reproductive Medicine","Center for Natural IVF","IVF Florida","Viera Fertility Center/Fertility and Reproductive Medicine Center for Women","Conceptions Florida: Center for Fertility and Genetics","Fertility and IVF Center of Miami","S. Florida Institute for Reproductive Med","University of Miami Infertility Center","Center for Reproductive Medicine PA","New Leaders in Fertility &amp; Endocrinology, LLC","Fertility and Genetics","The Reproductive Medicine Group","University of South Florida IVF","Florida Institute for Reproductive Sciences and Technologies (FIRST)","Fertility Center of Assisted Reproduction and Endocrinology","Emory Reproductive Center","Georgia Reproductive Specialists","Reproductive Biology Associates","Atlanta Center for Reproductive Medicine","MCG Reproductive Medicine and Infertility Associates","Servy Institute for Reproductive Endocrinology","Central Georgia Fertility Institute","Georgia Center for Reproductive Medicine","Advanced Reproductive Center of Hawaii","Advanced Reproductive Medicine and Gynecology of Hawaii","Pacific IVF Institute","Tripler Army Medical Center","Mid-Iowa Fertility, P.C.","Center for Advanced Reproductive Care","Idaho Center for Reproductive Medicine","Fertility Centers of Illinois- River North IVF","Northwestern University","University of Illinois at Chicago (UIC)","University of Chicago Medicine Center for Reproductive Medicine and Fertility","Midwest Fertility Center","Davies Fertility and IVF Specialists, S.C.","Advanced Fertility Center of Chicago","Highland Park IVF Center","Hinsdale Center for Reproduction","InVia Fertility Specialists","Reena Jabamoni MDSC","Reproductive Health Specialists","Advanced Reproductive Health Centers, LTD-Chicago IVF","IVF1","The Advanced IVF Institute - Charles E. Miller, MDSC and Assoc.","Reproductive Medicine Institute","Integramed Medical Illinois, LLC","Reproductive Health and Fertility Center","North Shore Fertility","Southern Illinois University School of Medicine, Fertility and IVF Center","Seth Levrant, M.D., PC","Midwest Fertility Specialists","Advanced Fertility Group","Advanced Fertility Group","Community Reproductive Endocrinology","Dr. John C. Jarrett II","Family Beginnings, PC","Indiana University IVF Program","Reproductive Care of Indiana","Boston IVF at the Women's Hospital","Women's Specialty Health Centers","Center for Advanced Reproductive Medicine","Midwest Reproductive Center, P A","Reproductive Resource Center of","Reproductive Medicine and Infertility","Center for Reproductive Medicine","University Women's Healthcare","A Woman's Center for Reproductive Medicine ","Fertility and Women's Health Center of Louisiana","The Fertility Institute of New Orleans","Audubon Fertility and Reproductive Medicine","Arklatex Fertility and Reproductive Medicine","Brigham & Women's Hospital Center for Assisted Reproduction","Massachusets General Hospital Fertility Center","Fertility Solutions, P.C. / Massachutsetts Fertility Center, L.L.C.","Reproductive Science Center ACTUALLY GAY IVF","Fertility Centers of New England","Baystate Reproductive Medicine","Cardone Reproductive Medicine &amp; Infertility LLC","Boston IVF","The Center for Assisted Reproductive Technology at UNION MEMORIAL","A.R.T.Institute of Washington, Inc.","Endrika Hinton, M.D. GBMC","Johns Hopkins Medical Institute","Shady Grove Fertility Center","Fertility Center of Maryland","Shady Grove Fertility Center at GBMC","Boston IVF, The Maine Center","University of Michigan Center for Reproductive Medicine","Advanced Reproductive Medicine and Surgery, P.C.","Gago IVF","Michigan Comprehensive Fertility Center","The Fertility Center","IVF Michigan","Wayne State University Physician Group","Brenda L. Moskovitz, M.D., P C","Henry Ford Medical Center","Reproductive Medicine Associates of Michigan","Michigan Center for Fertility and Women's Health PLC","Midwest Center for Reproductive Health","Center for Reproductive Medicine","Mayo Clinic-Assisted Reproductive Technologies","Reproductive Medicine and Infertility Associates","Center for Reproductive Medicine and Fertility","Mid Missouri Reproductive Medicine and Surgery, Inc.","Midwest Women's Healthcare","Infertility and Reproductive Medicine Center-Washington University St Louis","Mississippi Reproductive Medicine, PLLC","University of Mississippi Med Center","Billings Clinic Reproductive Medicine and Fertility Care","NC Center for Reproductive Medicine","Carolinas Medical Center","Reproductive Endocrinology Associates of Charlotte","Duke Fertility Center","ECU Women's Physicians","Premier Fertility Center","Advanced Reproductive Concepts","Atlantic Reproductive Medicine Specialists","Carolina Conceptions P A","UNC Fertility, LLC","Carolinas Fertility Institute","Wake Forest University Center for Reproductive Medicine","Sanford Reproductive Medicine","Reproductive Health Specialists","Heartland Center for Reproductive Medicine, P.C.","Dartmouth-Hitchcock Medical Center","Reproductive Medicine Associates of New Jersey","Reproductive Science Center of New Jersey, PA","Ctr for Advanced Reproductive Medicine & Fertility","North Hudson IVF","University Reproductive Associates","Shore Institute for Reproductive Medicine","Princeton IVF/Delaware Valley Ob/Gyn and Infertility Group","Institute for Reproductive Medicine & Science","Cooper Institute for Reproductive Hormonal Disorders PC","Delaware Valley Institute of Fertility and Genetics","South Jersey Fertility Center","Diamond Institute for Infertility","The Valley Hospital Fertility Center","Princeton Center for Reproductive Medicine","Damien Fertility Partners","IVF New Jersey","Louis R. Manara, D.O.","North Jersey Fertility Associates, LLC","Fertility Insitute of New Jersey and New York","Fertility Institute of New Jersey","Center for Reprod. Medicine of N Mexico","Fertility Center of Las Vegas","Red Rock Fertility Center","Nevada Center for Reproductive Medicine","Albany IVF, Fertility and Gynecology","Genesis Fertility and Reproductive Medicine","The Fertility Institute at New York Methodist Hospital","Infertility and IVF Medical Associates of Western NY","Hudson Valley Fertility","Montefiore Institute for Reproductive Medicine and Health","North Shore University Hospital","Long Island IVF","Reproductive Specialists of New York LLP","Westchester Reproductive Medicine","Beth Israel Center for Infertility and Reproductive Health","Brooklyn/Westside Fertility Center","Center for Human Reproduction","Manhattan Reproductive Medicine","Metropolitan Reproductive Medicine PC","New Hope Fertility Center","New York Fertility Institute","New York Fertility Services","New York University School of Medicine","Neway Medical","Offices for Fertility & Reproductive Medicine PC","Reproductive Medicine Associates of New York, LLP","Columbia University Center for Women's Reproductive Care","Geoffrey Sher, M.D., PC","Weill Medical College of Cornell University","East Coast Fertility","Rochester Fertility Care","Strong Fertility Center, University of Rochester Medical Center","Island Reproductive Services","CNY Fertility Center","Westchester Fertility & Reprod. Endo.","Braverman Reproductive Immunology, PC","Gold Coast IVF","Northeastern Ohio Fertility Center","Reproductive Gynecology","Cleveland Clinic Fertility Center-Beachwood","University Hospitals Fertility Center","Bethesda Fertility Center","Institute for Reproductive Health","UC Center for Reproductive Health","Ohio Reproductive Medicine","Wright State Physicians OB/GYN","Kettering Reproductive Medicine","Fertility Center of NW Ohio","Reproductive Gynecology, Inc.","Henry G. Bennett Jr. Fertility Institute","OU Physicians Reproductive Health","Tulsa Fertility Center","Northwest Fertility Center","Oregon Reproductive Medicine","University Fertility Consultants","Toll Center for Reproductive Sciences/Abington Reproductive Medicine PC","Reproductive Medicine Associates of Pennsylvania","Family Fertility Center","Main Line Fertility","Geisinger Medical Center Fertility Center","The Milton S. Hershey Medical Center","Reproductive Medicine Associates of Philadelphia","Fertility and Gynecology Associates","Society Hill Reproductive Medicine","University of Pennsylvania Penn Fertility Care","Jones Institute at West Penn Allegheny Health Systems","Reproductive Health Specialists, Inc.","University of Pittsburgh Physicians","Crozer Chester Medical Center","Shady Grove Fertility RSC of Philadelphia","RHPN Women's Clinic and IVF-Fertility","Women and Infants Hospital","Fertility Center of the Carolinas","Piedmont Reproductive Endocrinology Group PA","Southeastern Fertility Center","The Fertility Center of Charleston","Coastal Fertility Specialists","Advanced Fertility and Reproductive Endocrinology Institute, LLC","Sanford Fertility and Reproductive Medicine","Tennessee Reproductive Medicine","The Fertility Center of Chattanooga","University of Tennessee Medical Group","Quillen Fertility and Women's Services","Kutteh Ke Fertility Associates of Memphis, PLLC","Nashville Fertility Center. P.C.","The Center for Reproductive Health","Austin Fertility Center","Austin Fertility Institute, PA","Austin Fertility and Reproductive Medicine-Westlake IVF","RMA of Texas San Antonio","Texas Fertility Center, Drs Vaughn, Silverberg & Hansard","Center for Assisted Reproduction","Dallas-Fort Worth Fertility Associates","Fertility Center of Dallas","Fertility and Advanced Reproductive Medicine","Repromed Fertility Center","The Texas Center for Reproductive Health","Sher Institute for Reproductive Medicine-Dallas","The Women's Place","Southwest Center for Reproductive Health","Brooke Army Medical Center","Fort Worth Fertility PA","Dallas IVF","Fertility Specialists of Texas, PLLC","Frisco Institute for Reproductive Medicine","Houston Fertility Institute","Advanced Fertility Center of Texas","Baylor Family Fertility Program","Fertility Specialists of Houston","Houston IVF","Houston Infertility Clinic","University of Texas Fertility Clinic","IVFMD","Center for Reproductive Medicine","Texas Tech University Health Sciences Center","Fertility Institute of Texas","Advanced Fertility Centers, PLLC","IVF Plano","Presbyterian Hospital Plano ARTS","Fertility Center of San Antonio","Institute for Women's Health-Advanced Fertility","Reproductive Medicine Associates of Texas, PA","UT Medicine Fertility Center","North Houston Center for Reprod. Medicine","Center of Reproductive Medicine","Utah Fertility Center","Utah Center for Reproductive Medicine","Reproductive Care Center","Washington Fertility Center","Dominion Fertility & Endocrinology","Reproductive Medicine and Surgery Center of Virginia","Genetics and IVF Institute","Partners for Fertility and IVF","Jones Institute for Reprod Medicine","Virginia Center for Reproductive Medicine","Fertility Institute of Virginia","LifeSource Fertility Center","Richmond Center for Fertility","University Center for Advanced Reproductive Medicine","New Hope Center for Reproductive Medicine","Vermont Center for Reproductive Medicine","Northeastern Reproductive Medicine","Eastside Fertility Laboratory","Overlake Reproductive Health, Inc.","Poma Fertility","Olympia Women's Health","Pacific NW Fertility and IVF Specialists","Sound Fertility Care, PLLC","University Reproductive Care-University of WA","Seattle Reproductive Medicine","Center for Reproductive Endo & Fertility","SRM Spokane","GYFT Clinic","Madigan Healthcare Systems","The Women's Center at Aurora BayCare Medical Center","Froedtert and Medical College of Wisconsin","Generations Fertility Care","Wisconsin Fertility Institute","Reproductive Specialty Center","Gundersen Fertility Center","Aurora Fertility Services-West Allis Memorial Hospital","West Virginia University","Pedro J. Beauchamp, M.D. IVF Program","GREFI","Gay Parents AZ"]

keywords = ['LGBT','lesbian','gay']
# keywords = ['gay','lesbian','alternative','non-traditional','same-sex','same sex','trans','transgender','bisexual','homosexual','LGBT','LGBTQ','LGBTQI','queer','orientation','female-to-male','male-to-female']

sites = ['www.azfertility.com','http://beverlyhills.reproductivepartners.com']
# sites = ['www.azfertility.com','http://beverlyhills.reproductivepartners.com','http://coloradofertility.com']
# sites = ['www.azfertility.com','http://beverlyhills.reproductivepartners.com','http://coloradofertility.com','http://fertilityprogramalabama.com','http://pacificreproductivecenter.com','http://www.columbiafertility.com','http://www.conceptionsrepro.com','http://www.ctfertility.com','http://www.drbachus.com','http://www.goivf.com','http://www.greenwichivf.com','http://www.novaivf.com','http://www.pacificfertilitycenter.com','http://www.pamf.org/fertility','http://www.parkavefertility.com','http://www.rmact.com','http://www.rmfcfertility.com','http://www.rockymountainfertility.com','http://www.uconnfertility.com','https://www.arcfertility.com/arc-fertility-clinics/arc-practices-colorado/advanced-reproductive-medicine-university-colorado','https://www.ccrmivf.com']



Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = 'https://www.bing.com'

module MyCapybaraTest
  class Test
    include Capybara::DSL
    def get_bing_results_count(keyword, site, csv)
      visit('/')

      query = '+' + keyword + ' site:' + site
      fill_in "q", :with => query
      click_button 'Search'
      sleep(1)
      # result_count = first('#resultStats').text.gsub('About ','').gsub(' results','')
      result_count = all('.b_algo').length
      links = ""
      if result_count > 0 
        result_count = first('.sb_count').text.gsub(' RESULTS','')
        all('.b_algo h2 a').each do |r|
          links = links + r[:href] + ', '
        end
      end

      puts result_count.to_s + ": " + keyword + " site:" + site
      csv << [keyword,site,"Ok",result_count,links]
    end

    def get_bing_top_result(keyword, csv)
      visit('/')

      query = keyword + " fertility clinic"
      fill_in "q", :with => query
      click_button 'Search'
      sleep(1)
      first('.b_algo h2 a')[:href]
      csv << [first('.b_algo h2 a')[:href]]
    end

  end
end

CSV.open('./fertility-sites.csv', 'w+') do |csv|
  csv << ["Links"]

  site_titles.each do |title|
      t = MyCapybaraTest::Test.new
      t.get_bing_top_result(title, csv)
  end
end

# CSV.open('./output.csv', 'w+') do |csv|
#   csv << ["Keyword","Site","Status","Count","First 8 Links"]

#   sites.each do |site|
#     keywords.each do |keyword|
#       t = MyCapybaraTest::Test.new
#       t.get_bing_results_count(keyword, site, csv)
#     end
#   end
# end
