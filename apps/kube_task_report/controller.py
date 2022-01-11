import json
import yaml
from kubernetes import client, config, watch
import os

DOMAIN = "taskreport.marufeuille.dev"


if __name__ == "__main__":
    definition = 'crd.yaml'
    if 'KUBERNETES_PORT' in os.environ:
        config.load_incluster_config()
    else:
        config.load_kube_config()

    configuration = client.Configuration()
    api_client = client.api_client.ApiClient(configuration=configuration)
    v1 = client.ApiextensionsV1beta1Api(api_client)
    #current_crds = [x['spec']['names']['kind'].lower() for x in v1.list_custom_resource_definition().to_dict()['items']]
    #if 'taskreport' not in current_crds:
    #    print("Creating taskreport definition")
    #    with open(definition) as data:
    #        body = yaml.load(data)
    #    v1.create_custom_resource_definition(body)
    crds = client.CustomObjectsApi(api_client)

    print("Waiting for TaskReports to come up...")
    resource_version = ''
    while True:
        stream = watch.Watch().stream(crds.list_cluster_custom_object, DOMAIN, "v1beta1", "taskreport", resource_version=resource_version)
        for event in stream:
            obj = event["object"]
            operation = event['type']
            spec = obj.get("spec")
            if not spec:
                continue
            metadata = obj.get("metadata")
            resource_version = metadata['resourceVersion']
            name = metadata['name']
            print("Handling %s on %s" % (operation, name))