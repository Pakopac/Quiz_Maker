<?php

namespace App\DataFixtures;

use App\Entity\Answers;
use App\Entity\Questions;
use App\Entity\Quiz;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Common\Persistence\ObjectManager;

class AppFixtures extends Fixture
{
    public function load(ObjectManager $manager)
    {
        $quiz = new Quiz();
        $question = new Questions();
        $answerA = new Answers();
        $answerB = new Answers();
        $answerC = new Answers();
        $answerD = new Answers();

        $answerA->setContent("Maxime");
        $answerB->setContent("Wassim");
        $answerC->setContent("Louis");
        $answerD->setContent("Le monde");

        $question->setContent("Qui est le plus gros ?")
            ->addAnswer($answerA)
            ->addAnswer($answerB)
            ->addAnswer($answerC)
            ->addAnswer($answerD)
            ->setTrueAnswer(1);

        $quiz->setAuthor("admin")
            ->setDate(new \DateTime())
            ->setName("Dev2020 Quiz")
            ->addQuestion($question);

        $manager->persist($quiz);
        $manager->persist($question);
        $manager->persist($answerA);
        $manager->persist($answerB);
        $manager->persist($answerC);
        $manager->persist($answerD);

        $manager->flush();
    }
}
