#* Generate a student report for the ORExt.
#* @param ssid The statewide student identifier. Should be numeric.
#* @param year The year of the test. Should be in the form YYYY-YY.
#* @param name Student's name (first and last).
#* @param content The test content area. Should be one of "ELA", "Math",
#*   or "Science".
#* @param birth_date The student's birth date.
#* @param test_date The date the assessment was administered.
#* @param assessor_name The name of the person administering the assessment.
#* @param schid The statewide school identifier.
#* @param sch_name The name of the school.
#* @param distid The statewide district identifier.
#* @param dist_name The name of the district.
#* @param county_name The name of the county in which the school is located.
#* @param score The student's scale score on the assessment.
#* @serializer html
#* @get /report

function(ssid, year, name, grade, content, birth_date, test_date,
         assessor_name, schid, sch_name, distid, dist_name,
         county_name, score, return = "html") {

  outfile <- paste0(ssid, "-", content, ".html")

  rmarkdown::render(
    "score-report.Rmd",
   output_file = outfile,
    params = list(
      ssid = ssid,
      year = year,
      name = name,
      grade = grade,
      content = content,
      birthdate = birth_date,
      testdate = test_date,
      assessor = assessor_name,
      school_id = schid,
      school_name = sch_name,
      district_id = distid,
      district_name = dist_name,
      county_name = county_name,
      score = score
    )
  )
  readBin(outfile, "raw", n = file.info(outfile)$size)
}
