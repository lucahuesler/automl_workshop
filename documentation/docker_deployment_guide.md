# Deploying RStudio with h2o on DigitalOcean using Docker

## 1. Creating the Docker Image

### a. Dockerfile Creation

Your Dockerfile should look like this:

```{Dockerfile}

# Use the rocker/tidyverse image as a base 
FROM rocker/tidyverse:latest

# Install system libraries required by h2o

RUN apt-get update && apt-get install -y\
default-jdk\
libssl-dev\
libcurl4-openssl-dev\
libxml2-dev

# Install h2o package

RUN R -e "install.packages('h2o', repos='https://cloud.r-project.org/')"

# Copy workshop files into the Docker image

COPY . /home/rstudio/auto_ml_workshop 

```

### b. Building the Docker Image

Navigate to the directory containing the Dockerfile and run:

```{bash}
sudo docker build -t lucahuesler/rstudio-h2o:latest . 
```

### c. Pushing the Docker Image to Docker Hub

First, log in to Docker:

`sudo docker login`

Then, push the image:

`sudo docker push lucahuesler/rstudio-h2o:latest`

## 2. Creating the DigitalOcean Droplet

### a. Create a New Droplet

-   Log in to your DigitalOcean account.
-   Click "Create" and select "Droplets".
-   Choose an image (e.g., Ubuntu).
-   Choose a plan (Standard is fine for most use cases).
-   Add your SSH key for secure access.
-   Choose a data center region.
-   Click "Create Droplet".

### b. Accessing the Droplet via SSH

From your local machine:

`bash ssh root@YOUR_DROPLET_IP`

## 3. Deploying the Docker Image on the DigitalOcean Droplet

### a. Installing Docker on the Droplet

Run the following on your Droplet:

`sudo apt update sudo apt install docker.io sudo systemctl start docker sudo systemctl enable docker`

### b. Pulling and Running the Docker Image

`docker pull lucahuesler/rstudio-h2o:latest`

`docker run -d -p 8787:8787 -e PASSWORD=statistiktage2023 lucahuesler/rstudio-h2o:latest`

Replace `your_desired_password` with the password you want users to use for RStudio.

### c. Accessing RStudio

Once the Docker container is running, you (and your participants) can access RStudio by navigating to:

`http://YOUR_DROPLET_IP:8787`

------------------------------------------------------------------------

**Optional Steps**:

-   Set up a custom domain to point to the Droplet for easier access.
-   Set up a reverse proxy (using Nginx or Apache) on the Droplet to avoid specifying the port in the URL.
