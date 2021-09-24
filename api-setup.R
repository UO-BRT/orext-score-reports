#* Generate a student report for the ORExt
#* @param ssid The statewide student identifier. Should be numeric.
#* @param year The year of the test. Should be in the form YYYY-YY
#* @param name Student's name (first and last)
#* @param content The test content area. Should be one of "ELA", "Math", or "Science"
#* @param birth_date The student's birth date. 
#* @serializer html
#* @get /report

function(ssid, year, name, grade, content, birth_date, test_date, 
         teacher_name, schid, sch_name, distid, dist_name, countyid, 
         county_name, score) {
  
  outfile <- paste0(ssid, '-', content, '.html')
  
  rmarkdown::render(
    'score-report.Rmd',
   output_file = outfile,
    params = list(
      ssid = ssid, 
      year = year, 
      name = name, 
      grade = grade, 
      content = content,
      birthdate = birth_date, 
      testdate = test_date,
      teacher = teacher_name, 
      school_id = schid, 
      school_name = sch_name,
      district_id = distid, 
      district_name = dist_name,
      county_id = countyid,
      county_name = county_name, 
      score = score
    )
  )
  
  readBin(outfile, "raw", n = file.info(outfile)$size)
}
