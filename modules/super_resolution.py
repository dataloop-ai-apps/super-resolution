import dtlpy as dl
import logging

from ISR.models import RDN, RRDN

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(name='SuperResolution')


class ServiceRunner(dl.BaseServiceRunner):
    def __init__(self):
        self.RDN_WEIGHTS = ['psnr-small', 'psnr-large', 'noise-cancel']
        self.RRDN_WEIGHTS = ['gans']

    def super_res(self, item: dl.Item, context: dl.Context):
        if context is not None and context.node is not None and 'customNodeConfig' in context.node.metadata:
            node = context.node
            weights = node.metadata['customNodeConfig']['weights']
            logger.info('Weights set to: {}'.format(weights))
        else:
            raise ValueError("Node configration in context is missing, can't determinate the weights")

        lr_img = item.download(save_locally=False, to_array=True)
        if weights in self.RDN_WEIGHTS:
            rdn = RDN(weights=weights)
        elif weights in self.RRDN_WEIGHTS:
            rdn = RRDN(weights=weights)
        else:
            raise ValueError(f'Unknown weights: {weights}. Available weights: {self.RDN_WEIGHTS + self.RRDN_WEIGHTS}')
        sr_img = rdn.predict(lr_img)
        sr_item = item.dataset.items.upload(local_path=sr_img,
                                            remote_path=f"/super_resolution/{weights.replace('-', '_')}{item.dir}",
                                            remote_name=item.name,
                                            item_metadata={'system': {"originalItemId": item.id}},
                                            overwrite=True)
        return sr_item


def test():
    class Node:
        def __init__(self, metadata):
            self.metadata = metadata

    service_runner = ServiceRunner()
    item = dl.items.get(item_id='')
    context = dl.Context()
    context._node = Node(metadata={'customNodeConfig': {'weights': 'gans'}})
    service_runner.super_res(item=item, context=context)


if __name__ == '__main__':
    test()
