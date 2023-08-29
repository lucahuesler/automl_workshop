# Use the official RStudio image as a base
FROM rocker/tidyverse:latest

# Update APT repository list, fix broken installs, and install system libraries
RUN apt-get update -y && \
    apt-get -f install && \
    apt-get install -y --no-install-recommends default-jdk libssl-dev libcurl4-openssl-dev libxml2-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install packages
RUN R -e "install.packages('h2o')"

# Copy workshop file and .Rprofile to the Docker image
COPY auto_ml_workshop.qmd /home/rstudio/
COPY data /home/rstudio/data

# Change ownership of the workshop directory to rstudio
RUN chown -R rstudio:rstudio /home/rstudio/


# Create multiple users and set up their environments
RUN for i in $(seq 1 50); do \
        useradd -m sst$i -d /home/sst$i && \
        echo "sst$i:sst$i" | chpasswd && \
        mkdir /home/sst$i/workshop && \
        chown -R sst$i:sst$i /home/sst$i/workshop && \
        cp /home/rstudio/auto_ml_workshop.qmd /home/sst$i/workshop/ && \
        cp -r /home/rstudio/data /home/sst$i/workshop/ && \
        chown -R sst$i:sst$i /home/sst$i; \
    done

# Be in workshop folder when user logs in
RUN for i in $(seq 1 50); do echo 'setwd("~/workshop")' >> /home/sst$i/.Rprofile; done

# Set the theme "cobalt"
RUN for i in $(seq 1 50); do \
    mkdir -p /home/sst$i/.config/rstudio/ && \
    echo '{ "editor_theme" : "Cobalt" }' > /home/sst$i/.config/rstudio/rstudio-prefs.json && \
    chown -R sst$i:sst$i /home/sst$i/.config; \
done

