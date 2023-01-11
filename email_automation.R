#
#
#      E_mail automation from ARA
#
#

install.packages("mailR")
install.packages("markdown")
install.packages("knitr")

library(mailR)
library(markdown)
library(knitr)

##############################################################




# Load the 'mailR' library
library(mailR)

# Set up the email details
sender <- "max.ull@online.no"

recipients <- c("max.ull@online.no", "maxu@nih.no")

custom_names <- c("Max", "Maximillian")

subject <- "Hello!"

body <- "Hello, [custom_name]! This is a test email. 

I am testing out new email sending options for ARA"

# Send the email
for (i in 1:length(recipients)) {
        # Replace [custom_name] with the corresponding custom name
        body_with_name <- gsub("\\[custom_name\\]", custom_names[i], body)
        send.mail(from = sender, to = recipients[i], subject = subject, body = body_with_name,
                  smtp = list(host.name = "smtp.online.no", port = 587, user.name = sender, passwd = "788ivdwe", ssl = TRUE),
                  authenticate = TRUE, send = TRUE)
}




######################################################################


# Set up the email details
sender <- "max.ull@online.no"
recipients <- c("max.ull@online.no", "maxu@nih.no")
custom_names <- c("Max", "Martin")
subject <- "Hello!"

# Define the email body as a character vector in markdown format
body_md <- c("# Title\n",
             "Hello, [custom_name]! This is a test email with R markdown output.\n",
             "## Subtitle\n",
             "This is a paragraph.\n",
             "| Column 1 | Column 2 |\n",
             "|----------|----------|\n",
             "| Value 1  | Value 2  |\n",
             "## Figure\n",
             "```{r}\n",
             "x <- 1:10\n",
             "y <- x^2\n",
             "plot(x, y)\n",
             "```\n"
)

# Render the email body as HTML
body_html <- markdownToHTML(text = paste(body_md, collapse = "\n"), fragment = TRUE, options = c("base64_images"))


# Define the R Markdown file
rmarkdown_file <- tempfile(fileext = ".Rmd")
cat(paste(body_md, collapse = "\n"),file = rmarkdown_file)

# Render the R Markdown file to HTML
html_file <- knit2html(rmarkdown_file)

# Send the email
for (i in 1:length(recipients)) {
        # Replace [custom_name] with the corresponding custom name
        body_with_name <- gsub("\\[custom_name\\]", custom_names[i], body_html)
        send.mail(from = sender, to = recipients[i], subject = subject, 
                  html_body = body_with_name,
                  attach.files = html_file, # attach the html output from the R markdown file
                  smtp = list(host.name = "smtp.online.no", port = 587, user.name = sender, passwd = "788ivdwe", ssl = TRUE),
                  authenticate = TRUE, send = TRUE)
}










