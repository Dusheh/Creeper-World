using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

namespace Dushe_h.TaskSystem
{
    public class Task : IComparable<Task>
	{
        public int priorityLevel;
        public string taskName;

        public int CompareTo(Task task)
        {
            return priorityLevel.CompareTo(task.priorityLevel);
        }
    }

    public class TaskExecutor
    {
        public List<Task> tasks = new();

        private List<Task> pool = new();
        private int poolCount = 0;
        private int poolIndex = 0;

        private bool enableSort;

        public bool EnableSort
        {
            get { return enableSort; }
            set { enableSort = value; }
        }

        public TaskExecutor()
        {
            TaskSystem.instance.executor.Add(this);
        }

        protected virtual void AddTemp(Task temp)
        {
            if (++poolIndex > poolCount)
            {
                pool.Add(temp);
                poolCount++;
            }
            else pool[poolIndex - 1] = temp;
        }

        public virtual Task GetTemp()
        {
            if (poolCount > 0)
            {
                if (poolIndex == 0) return null;
                return pool[--poolIndex];
            }
            else return null;
        }

        public virtual void DoTask(Task _task)
        {

        }

		public virtual void Execute() 
        {
            if (enableSort) tasks.Sort();

            foreach (var task in tasks)
            {
                AddTemp(task);
                DoTask(task);
            }

            tasks.Clear();
        }

        protected int onceToDo = 5;

        public virtual void ExecuteAsync()
        {
            if (enableSort) tasks.Sort();

            for(int i = 0; i < onceToDo && i < tasks.Count; i++)
			{
                AddTemp(tasks[i]);
				DoTask(tasks[i]);
			}
            tasks.RemoveRange(0, Mathf.Min(onceToDo, tasks.Count));
		}
    }

    public class TaskSystem : MonoBehaviour
    {
        public List<TaskExecutor> executor = new();

        public int ExecutorCount = 0;

        public static TaskSystem instance;

		public void Awake()
		{
			instance = this;
		}

        public static void Add(TaskExecutor executor)
        {
            instance.executor.Add(executor);
        }

		public void FixedUpdate()
		{
			foreach (var exec in executor)
            {
                exec.Execute();
            }
		}
	}
}
