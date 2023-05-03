using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Dushe_h.TaskSystem;
using System.Linq;

public class MoveTask : Task
{
    public Transform transform;
    public Vector3 current
    {
        get { return transform.position; }
        set { transform.position = value; }
    }
    public Vector3 target;
    public float moveSpeed;
}

public class MoveExecutor : TaskExecutor
{
	public override void DoTask(Task _task)
	{
		base.DoTask(_task);

        var task = (MoveTask) _task;

        task.current = Vector3.MoveTowards(task.current, task.target, task.moveSpeed);
	}
}