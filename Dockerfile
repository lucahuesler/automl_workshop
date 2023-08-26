# Use the official RStudio image as a base
FROM rocker/tidyverse:latest

# Install system libraries required by h2o
RUN apt-get update && apt-get install -y \
    default-jdk \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev

# Install packages
RUN R -e "install.packages('h2o', repos='https://cloud.r-project.org/')"


# Copy workshop files into the Docker image
COPY . /home/rstudio/auto_ml_workshop
