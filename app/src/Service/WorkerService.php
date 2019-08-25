<?php

namespace App\Service;

use Pheanstalk\Contract\PheanstalkInterface;

class WorkerService
{
    public const DEFAULT_TUBE_NAME = 'default';

    /* @var PheanstalkInterface */
    protected $worker;

    /**
     * WorkerService constructor.
     * @param PheanstalkInterface $worker
     */
    public function __construct(PheanstalkInterface $worker)
    {
        $this->worker = $worker;
    }

    /** Run worker */
    public function runWorker()
    {
        $this->worker->watch(self::DEFAULT_TUBE_NAME);

        while ($job = $this->worker->reserve()) {
            $data = $job->getData();

            printf("%s\n", $data);

            $this->worker->delete($job);
        }
    }
}
