# Deploy Approuter in Kyma
This repository is how to create a service instance in Kyma runtime and secure applications with authentication and authorization. 

## How to deploy
The application has two deployment files. 
1. **service.yaml**: This is the yaml responsible to create [XSUAA Service Instance](https://help.sap.com/docs/BTP/65de2977205c403bbc107264b8eccf4b/2ce1a962c3be48dd8035513b0a2d7397.html)
2. **deployment.yaml**: This yaml helps in deploying the application, binding the XSUAA service instance to the application to secure it. 

## Set your working repository
To deploy the application to your namespace by default use the following command:
``` 
kubectl config set-context --current --namespace <your namespace>
```

## Steps to create XSUAA service instance
1. Open the **service.yaml** file. 
2. Replace `<cluster domain>` with your cluster domain
3. Replace `namespace` with namespace where you are deploying the application. 
4. Replace `<id>` at line 11 with your inumber. XSAPPNAME should be unique. 
5. Deploy the yaml to your cluster by using the command 
   ```
   kubectl apply -f service.yaml
   ```
This will deploy the application to your cluster

## Steps to deploy the Approuter application
Approuter application is used to provide a single entry point to that business application. It has the responsibility to:

- Dispatch requests to backend microservices (reverse proxy)
- Authenticate users
- Serve static content

We have the approuter image already deployed in docker hub. You can rebuild and deploy the image in your own repository.
### Command to build
```
docker build  --rm -f "Dockerfile" -t <your docker repo>/approuterinkyma:latest "."   --no-cache
```
for mac m1 chip add `--platform=linux/amd64`

### Push the image
```
docker push gopalanand/approuterinkyma:latest 
```

## Deploy the application 
1. Open `deployment.yaml` file and replace the `<cluster url>` at line 74 with your cluster url. 
2. Deploy the application and bind it to xsuaa service created in the previous step. Use the following command:
   ```
   kubectl apply -f deployment.yaml
   ```

This will deploy the application. Now you can go to the kyma cluster, open your namespace and then in the api rule you can access the application 


## Understanding the application 
The application initially showcases authentication. That means a user requires to log in to access the application.
Once you access the application click on **Info** this will throw a forbidden error. 

### Assign roles to your user.
1. To access the authenticated endpoint, go to the BTP cockpit, and inside security look for role collection.
2. Assign **Approuterkyma** role to your user.
3. Copy the URL of the application and open it in an incognito window. This time you will be able to see your details.






