# install.packages(c("httr2", "readr")) # if needed

library(httr2)
library(readr)
library(data.table)

# Zenodo DOI: 10.5281/zenodo.11662064
zenodo_api <- "https://zenodo.org/api/records/11662064"

# Retrieve file metadata
record <- request(zenodo_api) |>
  req_perform() |>
  resp_body_json()

# Extract download URL for the CSV file
files     <- record$files
csv_file  <- Filter(\(f) grepl("\\.csv$", f$key), files)[[1]]
dl_url    <- csv_file$links$self
dest      <- "C:/Users/cedot/OneDrive/Documentos/0_PSICO/96_SONHOS_ESTUDOS/dream_export.csv"

# Download
request(dl_url) |>
  req_perform() |>
  resp_body_raw() |>
  writeBin(dest)

# Read saved locally
dreams <- read_csv(dest)
#glimpse(dreams)

# ---------------------------------------------
# exemplo
dreamsDT <- setDT(dreams)
dreams[,.N,by=.(`Race/Ethnicity`)]



