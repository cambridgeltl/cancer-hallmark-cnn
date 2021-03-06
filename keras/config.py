class Defaults(object):
    encoding = 'utf-8'
    filter_sizes = [3, 4, 5]
    filter_nums = [100, 100, 100]
    hidden_sizes = []
    batch_size = 50
    drop_prob = 0.5    # None for no dropout
    l2_lambda = None    # None for no l2 regularization
    learning_rate = 0.001
    #token_regex = r'(\S+)'    # regular expression for whitespace tokenization
    token_regex = r'([^\W_]+|.)'    # fine-grained tokenization
    random_seed = 0xC001533D
    max_vocab_size = 1000000    # how many words to read from the embedding
    epochs = 20
    verbosity = 1
    doc_size = 500
    optimizer = 'adam'
    fixed_embedding = False
    oversample = False    # balance class distribution by oversampling
    target_metric = 'fscore'
    threshold = False
    test = False
    oov = ''
