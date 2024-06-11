# Use an official Python runtime as a parent image.
FROM python:3.12.4-slim

# Set the working directory in the container.
WORKDIR /flask_app

# Copy the current directory contents into the container at /flask_app.
COPY flask_app/app.py /flask_app
COPY flask_app/requirements.txt /flask_app

ARG CLOUDSMITH_ENTITLEMENT_TOKEN

# Set the PIP_INDEX_URL environment variable.
ENV PIP_INDEX_URL=https://dl.cloudsmith.io/{CLOUDSMITH_ENTITLEMENT_TOKEN}/jack-test-org/jack-test-repo/python/simple/

# Install any needed packages specified in requirements.txt using the Cloudsmith repository.
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run app.py when the container launches
CMD ["python", "app.py"]
