<?php

namespace App\Command;

use App\Service\WorkerService;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class RunWorkerCommand extends Command
{
    protected static $defaultName = 'worker:run';

    /* @var WorkerService */
    protected $workerService;

    /**
     * RunWorkerCommand constructor.
     * @param WorkerService $workerService
     */
    public function __construct(WorkerService $workerService)
    {
        $this->workerService = $workerService;
        parent::__construct();
    }

    /* @inheritdoc */
    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $output->writeln('Worker is running ...');
        $this->workerService->runWorker();
    }
}
